import 'package:evently/core/constants/colors/evently_colors.dart';
import 'package:evently/core/constants/images/images_name.dart';
import 'package:evently/modules/layout/home/models/category_data.dart';
import 'package:evently/modules/layout/home/widgets/event_item_widget.dart';
import 'package:evently/modules/layout/home/widgets/tap_item_widget.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    var dynamic = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Column(
      children: [
        Container(
          height: dynamic.height * 0.25,
          padding: EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 20),
          decoration: BoxDecoration(
            color: theme.primaryColor,
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
                      Text("Welcome Back ✨", style: theme.textTheme.labelSmall),
                      Text("Momen Waleed", style: theme.textTheme.titleLarge),
                    ],
                  ),
                  Spacer(),
                  Row(
                    spacing: 10,
                    children: [
                      Icon(
                        Icons.wb_sunny_outlined,
                        size: 30,
                        color: EventlyColors.white,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: EventlyColors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "EN",
                          style: theme.textTheme.labelSmall!.copyWith(
                            color: EventlyColors.blue,
                            fontWeight: FontWeight.w700,
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
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(height: 16);
            },
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return EventItemWidget();
            },
          ),
        ),
      ],
    );
  }
}
