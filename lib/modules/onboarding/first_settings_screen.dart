import 'package:evently/core/constants/colors/evently_colors.dart';
import 'package:evently/core/constants/images/images_name.dart';
import 'package:evently/core/constants/services/local_storage_keys.dart';
import 'package:evently/core/constants/services/local_storage_services.dart';
import 'package:evently/core/constants/strings/main_strings.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/modules/onboarding/widgets/language_switch.dart';
import 'package:evently/modules/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routes/page_routes_name.dart';

class FirstSettingsScreen extends StatefulWidget {
  const FirstSettingsScreen({super.key});

  @override
  State<FirstSettingsScreen> createState() => _FirstSettingsScreenState();
}

class _FirstSettingsScreenState extends State<FirstSettingsScreen> {
  // bool isLanguageEN = true;
  // bool isLightMode = true;

  @override
  Widget build(BuildContext context) {
    var dynamicSize = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;

    var provider = Provider.of<SettingsProvider>(context);
    var local = AppLocalizations.of(context)!;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                ImagesName.headerLogo,
                width: dynamicSize.width * 0.4,
              ),
            ),
            Image.asset(
              ImagesName.firstSettings,
              fit: BoxFit.cover,
              width: dynamicSize.width,
            ),
            Text(local.personalize, style: theme.titleMedium, softWrap: true),
            Text(
              local.firstSettingsDescription,
              style: theme.bodyLarge!.copyWith(
                color: provider.isDark()
                    ? EventlyColors.white
                    : EventlyColors.black,
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(local.language, style: theme.titleSmall),
                    LanguageSwitch(
                      onLanguageChanged: (bool value) async {
                        provider.changeLanguage(value ? "en" : "ar");

                        await LocalStorageServices.setString(
                          LocalStorageKeys.languageKey,
                          value ? "en" : "ar",
                        );
                      },
                    ),
                    // ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(local.theme, style: theme.titleSmall),
                    GestureDetector(
                      onTap: () async {
                        provider.changeThemeMode(
                          provider.isDark() ? ThemeMode.light : ThemeMode.dark,
                        );
                        await LocalStorageServices.setBool(
                          LocalStorageKeys.darkThemeKey,
                          provider.isDark(),
                        );
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          color: !provider.isDark()
                              ? EventlyColors.white
                              : EventlyColors.blue,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            width: 3,
                            color: EventlyColors.blue,
                          ),
                        ),
                        child: AnimatedAlign(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          alignment: !provider.isDark()
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: EventlyColors.blue,
                            ),
                            child: Icon(
                              !provider.isDark()
                                  ? Icons.wb_sunny_outlined
                                  : Icons.mode_night_rounded,
                              color: EventlyColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, PageRoutesName.onboarding);
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
                  local.lets_start,
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
