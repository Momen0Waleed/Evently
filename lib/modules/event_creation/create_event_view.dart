import 'package:evently/core/constants/images/images_name.dart';
import 'package:evently/core/constants/services/snackbar_service.dart';
import 'package:evently/core/routes/page_routes_name.dart';
import 'package:evently/core/utils/firebase_firestore.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/database/events_data.dart';
import 'package:evently/modules/authentication/widgets/register_button_widget.dart';
import 'package:evently/modules/event_creation/widgets/tap_item_widget.dart';
import 'package:evently/modules/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart' show Provider;

import '../../core/constants/colors/evently_colors.dart';
import '../authentication/widgets/text_field_widget.dart';
import '../layout/home/models/category_data.dart';

class CreateEventView extends StatefulWidget {
  const CreateEventView({super.key, this.eventsData});
  final EventsData? eventsData;

  @override
  State<CreateEventView> createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  @override
  void initState() {
    super.initState();

    if (widget.eventsData != null) {
      // Fill text fields
      nameController.text = widget.eventsData!.eventTitle;
      descriptionController.text = widget.eventsData!.eventDescription;

      // Set category index (find the matching category by title or img)
      final index = categories.indexWhere(
        (cat) => cat.categoryTitle == widget.eventsData!.eventCategoryId,
      );
      if (index != -1) {
        currentTabIndex = index;
      }

      // Set date & time
      selectedDate = widget.eventsData!.selectedDate;
      selectedTime = widget
          .eventsData!
          .selectedDate; // same field since your model stores date+time
    }
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  DateTime? selectedTime;
  bool isDateValid = true;
  bool isTimeValid = true;

  int currentTabIndex = 0;
  List<CategoryData> categories = [
    CategoryData(
      categoryTitle: "Sport",
      categoryIcon: ImagesName.sportIcon,
      categoryImg: ImagesName.sportImageDark,
    ),
    CategoryData(
      categoryTitle: "Birthday",
      categoryIcon: ImagesName.birthdayIcon,
      categoryImg: ImagesName.birthdayImageDark,
    ),
    CategoryData(
      categoryTitle: "Meeting",
      categoryIcon: ImagesName.sportIcon,
      categoryImg: ImagesName.meetingImageDark,
    ),
    CategoryData(
      categoryTitle: "Holiday",
      categoryIcon: ImagesName.birthdayIcon,
      categoryImg: ImagesName.holidayImageDark,
    ),
    CategoryData(
      categoryTitle: "Gaming",
      categoryIcon: ImagesName.sportIcon,
      categoryImg: ImagesName.gamingImageDark,
    ),
    CategoryData(
      categoryTitle: "Eating",
      categoryIcon: ImagesName.sportIcon,
      categoryImg: ImagesName.eatingImageDark,
    ),
    CategoryData(
      categoryTitle: "Work Shop",
      categoryIcon: ImagesName.birthdayIcon,
      categoryImg: ImagesName.workShopImageDark,
    ),
    CategoryData(
      categoryTitle: "Exhibition",
      categoryIcon: ImagesName.sportIcon,
      categoryImg: ImagesName.exhibitionImageDark,
    ),
    CategoryData(
      categoryTitle: "Book Club",
      categoryIcon: ImagesName.birthdayIcon,
      categoryImg: ImagesName.bookClubImageDark,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var local = AppLocalizations.of(context)!;
    var provider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: provider.isDark() ? EventlyColors.dark:EventlyColors.white,
        title: Text(widget.eventsData == null ? local.create_event : local.edit_event),
      ),
      floatingActionButton: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: RegisterButtonWidget(
          bgColor: EventlyColors.blue,
          child: Text(
            widget.eventsData == null ? local.add_event : local.update_event,
            style: theme.textTheme.titleSmall!.copyWith(
              color: EventlyColors.white,
            ),
          ),
          buttonAction: () {
            setState(() {
              // Validate fields
              isDateValid = selectedDate != null;
              isTimeValid = selectedTime != null;
            });

            if (formKey.currentState!.validate()) {
              if (!isDateValid || !isTimeValid) {
                return;
              }
              final DateTime combinedDateTime = DateTime(
                selectedDate!.year,
                selectedDate!.month,
                selectedDate!.day,
                selectedTime!.hour,
                selectedTime!.minute,
              );

              var eventData = EventsData(
                eventID: widget.eventsData?.eventID,
                eventTitle: nameController.text,
                eventDescription: descriptionController.text,
                eventCategoryImg: categories[currentTabIndex].categoryImg,
                eventCategoryId: categories[currentTabIndex].categoryTitle,
                selectedDate: combinedDateTime,
              );

              EasyLoading.show();

              // FirebaseFirestoreUtils.createNewEvent(eventData).then((value) {
              //   Future.delayed(Duration(seconds: 2), () {
              //     EasyLoading.dismiss();
              //     if (value) {
              //       Navigator.pop(context);
              //       SnackbarService.showSuccessNotification("Event Created");
              //     } else {
              //       SnackbarService.showErrorNotification(
              //         "Something Went Wrong",
              //       );
              //     }
              //   });
              // });

              Future<bool> operation;
              if (widget.eventsData == null) {
                operation = FirebaseFirestoreUtils.createNewEvent(eventData);
              } else {
                operation = FirebaseFirestoreUtils.updateEventData(
                  eventData: eventData,
                );
              }

              operation.then((value) {
                Future.delayed(Duration(seconds: 2), () {
                  EasyLoading.dismiss();
                  if (value) {
                    Navigator.pushNamed(context, PageRoutesName.layout);
                    SnackbarService.showSuccessNotification(
                      widget.eventsData == null
                          ? local.event_created
                          : local.event_updated,
                    );
                  } else {
                    SnackbarService.showErrorNotification(
                      local.something_went_wrong,
                    );
                  }
                });
              });
            }
          },
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(categories[currentTabIndex].categoryImg),
                ),
                SizedBox(height: 10),
                DefaultTabController(
                  length: categories.length,
                  child: TabBar(
                    onTap: (index) {
                      setState(() {
                        currentTabIndex = index;
                      });
                    },
                    isScrollable: true,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(),
                    tabAlignment: TabAlignment.start,
                    labelPadding: EdgeInsets.symmetric(horizontal: 4),
                    tabs: categories.map((category) {
                      return TapItemWidget(
                        categoryData: category,
                        isSelected:
                            currentTabIndex == categories.indexOf(category),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20),
                Text(local.title, style: theme.textTheme.bodyLarge!.copyWith(
                  color: provider.isDark() ? EventlyColors.white : EventlyColors.black
                )),
                SizedBox(height: 10),
                TextFieldWidget(
                  color: provider.isDark() ? EventlyColors.dark : EventlyColors.white,
                  title: local.event_item,
                  prefixIcon: ImageIcon(
                    AssetImage(ImagesName.editTextIcon),
                    color: EventlyColors.gray,
                  ),
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return local.title_required;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                Text(local.description, style: theme.textTheme.bodyLarge!.copyWith(
                  color: provider.isDark() ? EventlyColors.white : EventlyColors.black,
                )),
                SizedBox(height: 10),
                TextFieldWidget(
                  color: provider.isDark() ? EventlyColors.dark : EventlyColors.white,
                  controller: descriptionController,
                  title: local.event_description,
                  maxlines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return local.description_is_required;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.calendar_month,
                      color: provider.isDark() ? EventlyColors.white : EventlyColors.black,
                    ),
                    SizedBox(width: 10),
                    Text(local.event_date, style: theme.textTheme.bodyLarge!.copyWith(
                      color: provider.isDark() ? EventlyColors.white : EventlyColors.black,
                    )),
                    Spacer(),
                    Bounceable(
                      onTap: () {
                        getCurrentDate();
                      },
                      child: Text(
                        selectedDate == null
                            ? local.choose_date
                            : DateFormat(
                                "yyyy MMM dd",
                              ).format(selectedDate!).toString(),
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: selectedDate == null
                              ? (isDateValid ? EventlyColors.blue : Colors.red)
                              : EventlyColors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.access_time,
                      color: provider.isDark() ? EventlyColors.white : EventlyColors.black,

                    ),
                    SizedBox(width: 10),
                    Text(local.event_time, style: theme.textTheme.bodyLarge!.copyWith(
                      color: provider.isDark() ? EventlyColors.white : EventlyColors.black,

                    )),
                    Spacer(),
                    Bounceable(
                      onTap: () {
                        getCurrentTime();
                      },
                      child: Text(
                        selectedTime == null
                            ? local.choose_time
                            : DateFormat(
                                "h:mm a",
                              ).format(selectedTime!).toString(),
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: selectedTime == null
                              ? (isTimeValid ? EventlyColors.blue : Colors.red)
                              : EventlyColors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                RegisterButtonWidget(
                bgColor: provider.isDark() ? EventlyColors.dark : EventlyColors.white,
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
                          local.choose_loc,
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
                SizedBox(height: 200),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getCurrentDate() {
    showDatePicker(
      initialDate: DateTime.now(),
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    ).then((value) {
      setState(() {
        selectedDate = value;
        isDateValid = true;
      });
    });
  }

  void getCurrentTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        // Combine with selectedDate if it exists, or use today
        final DateTime now = DateTime.now();
        final DateTime baseDate =
            selectedDate ?? DateTime(now.year, now.month, now.day);
        selectedTime = DateTime(
          baseDate.year,
          baseDate.month,
          baseDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        isTimeValid = true;
      });
    }
  }
}
