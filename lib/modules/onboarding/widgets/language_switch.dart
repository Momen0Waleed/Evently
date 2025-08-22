import 'package:evently/modules/settings_provider.dart' show SettingsProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors/evently_colors.dart';
import '../../../core/constants/images/images_name.dart';

class LanguageSwitch extends StatefulWidget {
  final ValueChanged<bool> onLanguageChanged;
  const LanguageSwitch({super.key, required this.onLanguageChanged});

  @override
  State<LanguageSwitch> createState() => _LanguageSwitchState();
}

class _LanguageSwitchState extends State<LanguageSwitch> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
  bool isLanguageEN = provider.isEnglish();
    return GestureDetector(
      onTap: () {
        setState(() {
          // isLanguageEN = provider.isEnglish();
          // isLanguageEN = !isLanguageEN;
          // widget.onLanguageChanged(isLanguageEN);
          widget.onLanguageChanged(!isLanguageEN);
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          color: provider.isDark() ? EventlyColors.dark:EventlyColors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 3, color: EventlyColors.blue),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: isLanguageEN
                    ? EventlyColors.blue
                    : Colors.transparent,
              ),
              padding: EdgeInsets.only(top: 3, bottom: 3, right: 3),
              child: CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage(ImagesName.flagUS),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: isLanguageEN
                    ? Colors.transparent
                    : EventlyColors.blue,
              ),
              padding: EdgeInsets.only(top: 3, bottom: 3, left: 3),
              child: CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage(ImagesName.flagEG),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
