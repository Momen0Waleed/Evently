import 'package:evently/core/constants/colors/evently_colors.dart';
import 'package:evently/core/constants/images/images_name.dart';
import 'package:evently/core/routes/page_routes_name.dart';
import 'package:evently/core/utils/firebase_firestore.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/database/events_data.dart';
import 'package:evently/modules/authentication/widgets/register_button_widget.dart';
import 'package:evently/modules/event_creation/create_event_view.dart';
import 'package:evently/modules/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ViewEventDetails extends StatelessWidget {
  const ViewEventDetails({super.key});
  // final EventsData eventsData;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;

    if (args == null || args is! EventsData) {
      return const Scaffold(
        body: Center(child: Text("No event data provided")),
      );
    }

    final eventData = args;
    var theme = Theme.of(context);
    var provider = Provider.of<SettingsProvider>(context);
    var local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: provider.isDark() ? EventlyColors.dark:EventlyColors.white,
        title: Text(local.event_details,),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CreateEventView(eventsData: eventData),
                ),
              );
            },
            icon: Image.asset(
              ImagesName.updateEventIcon,
              width: 25,
              height: 25,
            ),
          ),
          // SizedBox(width: 5),
          IconButton(
            onPressed: () async {
              final confirm = await showEnsureDeletionDialog(context);
              if (confirm == true) {
                // Perform deletion here
                FirebaseFirestoreUtils.deleteEventData(eventData: eventData);
                Navigator.of(
                  context,
                ).pushReplacementNamed(PageRoutesName.layout);
              }
            },
            icon: Image.asset(
              ImagesName.deleteEventIcon,
              width: 25,
              height: 25,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(eventData.eventCategoryImg),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  eventData.eventTitle,
                  style: theme.textTheme.titleLarge!.copyWith(
                    color: EventlyColors.blue,
                  ),
                ),
              ),
              RegisterButtonWidget(
                bgColor: provider.isDark() ?EventlyColors.dark: EventlyColors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5.0,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 45,
                        height: double.infinity,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: EventlyColors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.calendar_month,
                          size: 26,
                          color: EventlyColors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat(
                              "dd MMM yyyy",
                            ).format(eventData.selectedDate).toString(),
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: EventlyColors.blue,
                            ),
                          ),
                          Text(
                            DateFormat(
                              "hh:mm a",
                            ).format(eventData.selectedDate).toString(),
                            style: theme.textTheme.bodyLarge!.copyWith(
                              color: provider.isDark() ? EventlyColors.white : EventlyColors.black
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              RegisterButtonWidget(
                bgColor:provider.isDark() ? EventlyColors.dark : EventlyColors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5.0,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 45,
                        height: double.infinity,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: EventlyColors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.my_location_rounded,
                          size: 26,
                          color: EventlyColors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Cairo, Egypt",
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: EventlyColors.blue,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: EventlyColors.blue,
                        size: 20,
                      ),
                    ],
                  ),
                ),
                buttonAction: () {},
              ),
              Container(
                width: double.infinity,
                height: 360,
                decoration: BoxDecoration(
                  border: Border.all(color: EventlyColors.blue, width: 2),
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.transparent,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(local.description, style: theme.textTheme.titleSmall),
              ),
              Text(
                eventData.eventDescription,
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: provider.isDark() ? EventlyColors.white: EventlyColors.black
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> showEnsureDeletionDialog(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return showDialog<bool>(
      context: context,
      barrierDismissible: true, // Prevents closing by tapping outside
      builder: (context) {
        return AlertDialog(
          backgroundColor:Provider.of<SettingsProvider>(context).isDark() ? EventlyColors.dark : EventlyColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(local.confirm_del,style: TextStyle(
            color: Provider.of<SettingsProvider>(context).isDark() ? EventlyColors.white : EventlyColors.black
          ),),
          content: Text(local.are_u_sure,style: TextStyle(
          color: Provider.of<SettingsProvider>(context).isDark() ? EventlyColors.white : EventlyColors.black
        )),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel
              },
              child: Text(
                local.cancel,style: TextStyle(
                  color: Provider.of<SettingsProvider>(context).isDark() ? EventlyColors.white : EventlyColors.black
              ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: EventlyColors.redError,
              ),
              onPressed: () {
                Navigator.of(context).pop(true); // Confirm
              },
              child: Text(
                local.delete,
                style: TextStyle(color: EventlyColors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
