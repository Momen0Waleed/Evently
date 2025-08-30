import 'package:evently/core/constants/colors/evently_colors.dart';
import 'package:evently/core/routes/page_routes_name.dart';
import 'package:evently/core/utils/firebase_firestore.dart';
import 'package:evently/models/database/events_data.dart';
import 'package:evently/modules/manager/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventItemWidget extends StatefulWidget {
  const EventItemWidget({super.key, required this.eventData});
 final EventsData eventData ;
  @override
  State<EventItemWidget> createState() => _EventItemWidgetState();
}

class _EventItemWidgetState extends State<EventItemWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<SettingsProvider>(context);
    return Bounceable(
      onTap: (){
        Navigator.of(context).pushNamed(PageRoutesName.eventDetails,arguments: widget.eventData);
      },
      child: Container(
        height: 200,
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(widget.eventData.eventCategoryImg),
            fit: BoxFit.cover,
          ),
          border: BoxBorder.all(
            width: 2,
            color: provider.isDark() ? EventlyColors.blue : EventlyColors.black
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: provider.isDark() ?EventlyColors.dark : EventlyColors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    DateFormat("dd").format(widget.eventData.selectedDate),
                    style: theme.textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w900,
                    height: 1
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    DateFormat("MMM").format(widget.eventData.selectedDate),
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: EventlyColors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                // color: EventlyColors.white,
                color: provider.isDark() ?EventlyColors.dark : EventlyColors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                       widget.eventData.eventTitle,
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                          // color: EventlyColors.black,
                          color: provider.isDark() ?EventlyColors.blue
                              : EventlyColors.black,

                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Bounceable(
                      onTap: (){
                        widget.eventData.isFavourite = !widget.eventData.isFavourite;
                        FirebaseFirestoreUtils.updateEventData(eventData: widget.eventData);
                      },
                      child: Icon(
                        widget.eventData.isFavourite
                        ? Icons.favorite
                        : Icons.favorite_border,
                        color: EventlyColors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
