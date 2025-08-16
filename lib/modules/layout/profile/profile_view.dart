import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:evently/core/constants/colors/evently_colors.dart';
import 'package:evently/core/constants/images/images_name.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;

import '../../settings_provider.dart' show SettingsProvider;

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var local = AppLocalizations.of(context)!;

    final List<String> languages = ["English", "العربية"];
    final List<String> themes = [local.light, local.dark];

    var provider = Provider.of<SettingsProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          padding: EdgeInsets.only(top: 25, left: 16, right: 16),
          decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(65)),
          ),
          child: Row(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 125,
                height: 125,
                decoration: BoxDecoration(
                  color: EventlyColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(1000),
                    bottomLeft: Radius.circular(1000),
                    bottomRight: Radius.circular(1000),
                  ),
                  image: DecorationImage(
                    image: AssetImage(ImagesName.profileImage),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Momen Waleed", style: theme.textTheme.titleLarge),
                  Text(
                    "mwgendia@gmail.com",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: EventlyColors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            local.languages,
            style: theme.textTheme.headlineSmall!.copyWith(
              color: provider.isDark() ? EventlyColors.white :  EventlyColors.black,
            ),
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CustomDropdown<String>(

            items: languages,
            initialItem: provider.currentLanguage == "en"
                ? "English"
                : "العربية",
            onChanged: (value) {
              provider.changeLanguage(value! == "English" ? "en" : "ar");
            },
            decoration: CustomDropdownDecoration(

              closedFillColor: Colors.transparent,
              // expandedFillColor: Colors.transparent,
              closedBorder: BoxBorder.all(
                width: 1.5,
                color: EventlyColors.blue,
              ),
              closedSuffixIcon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: EventlyColors.blue,
                size: 30,
              ),
              headerStyle: theme.textTheme.titleSmall,
            ),
          ),
        ),

        SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            local.theme_mode,
            style: theme.textTheme.headlineSmall!.copyWith(
              color: provider.isDark() ? EventlyColors.white :  EventlyColors.black,
            ),
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CustomDropdown<String>(
            items: themes,
            // initialItem: provider.isDark() ? "Dark" : "Light",
            initialItem: provider.isDark() ? local.dark : local.light,
            onChanged: (value) {
              provider.changeThemeMode(
                // value! == "Light" ? ThemeMode.light : ThemeMode.dark,
                value == local.light ? ThemeMode.light : ThemeMode.dark,
              );
            },
            decoration: CustomDropdownDecoration(
              closedFillColor: Colors.transparent,
              closedBorder: BoxBorder.all(
                width: 1.5,
                color: EventlyColors.blue,
              ),
              closedSuffixIcon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: EventlyColors.blue,
                size: 30,
              ),
              headerStyle: theme.textTheme.titleSmall,
            ),
          ),
        ),
      ],
    );
  }
}
