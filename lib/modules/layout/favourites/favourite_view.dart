import 'package:evently/core/constants/colors/evently_colors.dart';
import 'package:evently/core/utils/firebase_firestore.dart';
import 'package:evently/models/database/events_data.dart';
import 'package:evently/modules/layout/home/widgets/event_item_widget.dart';
import 'package:flutter/material.dart';

import '../../authentication/widgets/text_field_widget.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: TextFieldWidget(
            title: 'Search',
            prefixIcon: Icon(Icons.search_rounded, color: EventlyColors.blue),
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
              return Center(child: CircularProgressIndicator());
            }
            List<EventsData> eventDataList = snapshot.data!.docs.map((e) {
              return e.data();
            }).toList();
            if (eventDataList.isEmpty) {
              return Expanded(
                child: Center(
                  child: Text(
                    'You don’t have any Favourite Events yet',
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
