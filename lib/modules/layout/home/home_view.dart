import 'package:evently/core/constants/colors/evently_colors.dart';
import 'package:evently/core/constants/images/images_name.dart';
import 'package:evently/core/constants/services/local_storage_services.dart';
import 'package:evently/core/utils/firebase_firestore.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/database/events_data.dart';
import 'package:evently/modules/layout/home/models/category_data.dart';
import 'package:evently/modules/layout/home/widgets/event_item_widget.dart';
import 'package:evently/modules/layout/home/widgets/tap_item_widget.dart';
import 'package:evently/modules/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/services/local_storage_keys.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentTabIndex = 0;
  List<CategoryData> categories = [
    CategoryData(
      categoryTitle: "All",
      categoryIcon: ImagesName.allIcon,
      categoryImg: ImagesName.nothingIcon,
    ),
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

  // bool isEnglish = true;
  // bool isLightMode = true;
  @override
  Widget build(BuildContext context) {
    var dynamic = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    var local = AppLocalizations.of(context)!;
    var provider = Provider.of<SettingsProvider>(context);
    return Column(
      children: [
        Container(
          height: dynamic.height * 0.25,
          padding: EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 20),
          decoration: BoxDecoration(
            color:provider.isDark() ?EventlyColors.dark : theme.primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // spacing: 20,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        local.welcome_back,
                        style: theme.textTheme.labelSmall,
                      ),
                      Text("Momen Waleed", style: theme.textTheme.titleLarge),
                    ],
                  ),
                  Spacer(),
                  Row(
                    spacing: 10,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          // isLightMode = !isLightMode;
                          provider.changeThemeMode(
                            provider.isDark() ? ThemeMode.light : ThemeMode.dark,
                          );
                          await LocalStorageServices.setBool(
                            LocalStorageKeys.darkThemeKey,
                            provider.isDark(),
                          );
                        },
                        child: provider.isDark()
                            ? Icon(
                                Icons.wb_sunny_outlined,
                                size: 30,
                                color: EventlyColors.white,
                              )
                            : Icon(
                                Icons.dark_mode_outlined,
                                size: 30,
                                color: EventlyColors.white,
                              ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // isEnglish = !isEnglish;
                          provider.changeLanguage(provider.isEnglish() ? "ar" : "en");
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: EventlyColors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            provider.isEnglish() ? "EN" : "AR",
                            style: theme.textTheme.labelSmall!.copyWith(
                              color: provider.isDark() ? EventlyColors.dark : EventlyColors.blue,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                spacing: 6,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: EventlyColors.white,
                    size: 25,
                  ),
                  Text(
                    "Cairo, Egypt",
                    style: theme.textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
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
            ],
          ),
        ),

        StreamBuilder(
          stream: FirebaseFirestoreUtils.readEventData(
            catId: categories[currentTabIndex].categoryTitle,
          ),
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
            List<EventsData> eventDataList = snapshot.data!.docs.map((e) {
              return e.data();
            }).toList();
            if (eventDataList.isEmpty) {
              String categoryName =
                  "${categories[currentTabIndex].categoryTitle} Events";
              if (categoryName == "All Events") categoryName = "Events";

              return Expanded(
                child: Center(
                  child: Text(
                    'You don’t have any $categoryName yet',
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
