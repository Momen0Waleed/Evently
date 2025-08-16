import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier{
  String currentLanguage = 'en';
  ThemeMode currentThemeMode = ThemeMode.light;
  void changeLanguage(String newLang){
    if(currentLanguage == newLang) return;
    currentLanguage = newLang;
    notifyListeners();
  }
  void changeThemeMode(ThemeMode newTheme){
    if(currentThemeMode == newTheme) return;
    currentThemeMode = newTheme;
    notifyListeners();
  }

  bool isDark() => currentThemeMode == ThemeMode.dark;
}