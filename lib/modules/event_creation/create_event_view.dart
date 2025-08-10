import 'package:evently/core/constants/images/images_name.dart';
import 'package:evently/modules/authentication/widgets/register_button_widget.dart';
import 'package:evently/modules/event_creation/widgets/tap_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import '../../core/constants/colors/evently_colors.dart';
import '../authentication/widgets/text_field_widget.dart';
import '../layout/home/models/category_data.dart';

class CreateEventView extends StatefulWidget {
  const CreateEventView({super.key});

  @override
  State<CreateEventView> createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  final nameController = TextEditingController();

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
    return Scaffold(
      appBar: AppBar(title: Text("Create Event")),
      floatingActionButton: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: RegisterButtonWidget(
          bgColor: EventlyColors.blue,
          child: Text(
            "Add Event",
            style: theme.textTheme.titleSmall!.copyWith(
              color: EventlyColors.white,
            ),
          ),
          buttonAction: (){

          },
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
              Text("Title", style: theme.textTheme.bodyLarge),
              SizedBox(height: 10),
              TextFieldWidget(
                title: 'Event Item',
                prefixIcon: ImageIcon(
                  AssetImage(ImagesName.editTextIcon),
                  color: EventlyColors.gray,
                ),
                isPassword: false,
                isName: true,
                isLogin: false,
                controller: nameController,
              ),
              SizedBox(height: 15),
              Text("Description", style: theme.textTheme.bodyLarge),
              SizedBox(height: 10),
              TextFieldWidget(title: 'Event Description', maxlines: 5),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.calendar_month),
                  SizedBox(width: 5),
                  Text("Event Date", style: theme.textTheme.bodyLarge),
                  Spacer(),
                  Bounceable(
                    onTap: () {},
                    child: Text(
                      "Choose Date",
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: EventlyColors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.calendar_month),
                  SizedBox(width: 5),
                  Text("Event Time", style: theme.textTheme.bodyLarge),
                  Spacer(),
                  Bounceable(
                    onTap: () {},
                    child: Text(
                      "Choose Time",
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: EventlyColors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              RegisterButtonWidget(
                bgColor: EventlyColors.white,
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
                        "Choose Event Location",
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
              SizedBox(height: 200,)
            ],
          ),
        ),
      ),
    );
  }
}
