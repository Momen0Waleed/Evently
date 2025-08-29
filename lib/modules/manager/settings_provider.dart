import 'package:evently/core/constants/services/local_storage_keys.dart';
import 'package:evently/core/constants/services/local_storage_services.dart';
import 'package:flutter/material.dart';


class SettingsProvider extends ChangeNotifier{
  // String currentLanguage = 'en';
  // ThemeMode currentThemeMode = ThemeMode.light;

  String currentLanguage =
      LocalStorageServices.getString(LocalStorageKeys.languageKey) ?? 'en';
  ThemeMode currentThemeMode =
  (LocalStorageServices.getBool(LocalStorageKeys.darkThemeKey) ?? false)
      ? ThemeMode.dark
      : ThemeMode.light;

  void changeLanguage(String newLang){
    if(currentLanguage == newLang) return;
    currentLanguage = newLang;
    LocalStorageServices.setString(LocalStorageKeys.languageKey, newLang);
    notifyListeners();
  }
  void changeThemeMode(ThemeMode newTheme){
    if(currentThemeMode == newTheme) return;
    currentThemeMode = newTheme;
    LocalStorageServices.setBool(
      LocalStorageKeys.darkThemeKey,
      newTheme == ThemeMode.dark,
    );
    notifyListeners();
  }

  bool isDark() => currentThemeMode == ThemeMode.dark;
  bool isEnglish() => currentLanguage == "en";
}