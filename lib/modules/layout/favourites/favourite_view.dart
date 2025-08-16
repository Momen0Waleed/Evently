import 'package:evently/core/constants/colors/evently_colors.dart';
import 'package:evently/core/utils/firebase_firestore.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/database/events_data.dart';
import 'package:evently/modules/layout/home/widgets/event_item_widget.dart';
import 'package:evently/modules/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../authentication/widgets/text_field_widget.dart';

class FavouriteView extends StatefulWidget {
  const FavouriteView({super.key});

  @override
  State<FavouriteView> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    var provider = Provider.of<SettingsProvider>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: TextFieldWidget(
            color: provider.isDark() ? EventlyColors.dark : EventlyColors.white,
            title: local.search,
            prefixIcon: Icon(Icons.search_rounded, color: EventlyColors.blue),
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _searchQuery = value.toLowerCase();
              });
            },
          ),
        ),
        StreamBuilder(
          stream: FirebaseFirestoreUtils.readFavouriteEventData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                  style: TextStyle(color: EventlyColors.redError),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            List<EventsData> eventDataList = snapshot.data!.docs
                .map((e) => e.data())
                .where((event) => event.eventTitle
                .toLowerCase()
                .contains(_searchQuery))
                .toList();
            if (eventDataList.isEmpty) {
              return Expanded(
                child: Center(
                  child: Text(
                    local.no_fav_events,
                    style: TextStyle(
                      color: EventlyColors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            return Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(height: 16);
                },
                itemCount: eventDataList.length,
                itemBuilder: (context, index) {
                  return EventItemWidget(eventData: eventDataList[index]);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
