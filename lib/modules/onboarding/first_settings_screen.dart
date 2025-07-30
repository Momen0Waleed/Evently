import 'package:evently/core/constants/colors/evently_colors.dart';
import 'package:evently/core/constants/images/images_name.dart';
import 'package:evently/core/constants/strings/main_strings.dart';
import 'package:evently/modules/onboarding/on_boarding_screen.dart';
import 'package:evently/modules/onboarding/widgets/language_switch.dart';
import 'package:flutter/material.dart';

class FirstSettingsScreen extends StatefulWidget {
  const FirstSettingsScreen({super.key});
  static const String routeName = "/1st Settings";

  @override
  State<FirstSettingsScreen> createState() => _FirstSettingsScreenState();
}

class _FirstSettingsScreenState extends State<FirstSettingsScreen> {
  bool isLanguageEN = true;
  bool isLightMode = true;

  @override
  Widget build(BuildContext context) {
    var dynamicSize = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16,
          bottom: 25,
          top: 50,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(ImagesName.headerLogo, width: dynamicSize.width * 0.4),
            Image.asset(
              ImagesName.firstSettings,
              fit: BoxFit.cover,
              width: dynamicSize.width,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Personalize Your Experience",
                style: theme.titleMedium,
                softWrap: true,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                MainStrings.firstSettingsDescription,
                style: theme.bodyLarge,
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Language", style: theme.titleSmall),
                    LanguageSwitch(onLanguageChanged: (bool value) {
                      setState(() {
                        isLanguageEN = value;
                      });
                    },),
                    // GestureDetector(
                    //   onTap: () {
                    //     setState(() {
                    //       isLanguageEN = !isLanguageEN;
                    //     });
                    //   },
                    //   child: AnimatedContainer(
                    //     duration: Duration(milliseconds: 800),
                    //     curve: Curves.easeInOut,
                    //     width: 100,
                    //     height: 40,
                    //     decoration: BoxDecoration(
                    //       color: EventlyColors.white,
                    //       borderRadius: BorderRadius.circular(30),
                    //       border: Border.all(
                    //         width: 3,
                    //         color: EventlyColors.blue,
                    //       ),
                    //     ),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         AnimatedContainer(
                    //           duration: Duration(milliseconds: 500),
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(18),
                    //             color: isLanguageEN
                    //                 ? EventlyColors.blue
                    //                 : EventlyColors.white,
                    //           ),
                    //           padding: EdgeInsets.only(
                    //             top: 3,
                    //             bottom: 3,
                    //             right: 3,
                    //           ),
                    //           child: CircleAvatar(
                    //             radius: 18,
                    //             backgroundImage: AssetImage(ImagesName.flagUS),
                    //           ),
                    //         ),
                    //         AnimatedContainer(
                    //           duration: Duration(milliseconds: 500),
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(18),
                    //             color: isLanguageEN
                    //                 ? EventlyColors.white
                    //                 : EventlyColors.blue,
                    //           ),
                    //           padding: EdgeInsets.only(
                    //             top: 3,
                    //             bottom: 3,
                    //             left: 3,
                    //           ),
                    //           child: CircleAvatar(
                    //             radius: 18,
                    //             backgroundImage: AssetImage(ImagesName.flagEG),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Theme", style: theme.titleSmall),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLightMode = !isLightMode;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isLightMode ? EventlyColors.white : EventlyColors.blue,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            width: 3,
                            color: EventlyColors.blue,
                          ),
                        ),
                        child:
                        AnimatedAlign(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          alignment: isLightMode ? Alignment.centerLeft: Alignment.centerRight,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: EventlyColors.blue,
                            ),
                            child: Icon(
                              isLightMode ? Icons.wb_sunny_outlined : Icons.mode_night_rounded,
                              color: EventlyColors.white,
                            ) ,
                          ),
                        )
                      ),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                //TODO: Sending the Settings Data to the SharedPreferences
                Navigator.pushNamed(context, OnBoardingScreen.routeName);
              },
              child: Container(
                width: dynamicSize.width,
                height: 55,
                decoration: BoxDecoration(
                  color: EventlyColors.blue,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Let's Start",
                  style: theme.titleSmall!.copyWith(color: EventlyColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
