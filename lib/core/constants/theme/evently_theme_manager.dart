import 'package:evently/core/constants/colors/evently_colors.dart';
import 'package:flutter/material.dart';

abstract class EventlyThemeManager {
  static ThemeData eventlyThemeData = ThemeData(
    primaryColor: EventlyColors.blue,
    scaffoldBackgroundColor: EventlyColors.white,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: EventlyColors.white,
      iconTheme: IconThemeData(color: EventlyColors.blue),
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontFamily: "Inter",
        fontWeight: FontWeight.w700,
        color: EventlyColors.blue,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: EventlyColors.blue,
      selectedItemColor: EventlyColors.white,
      showSelectedLabels: true,
      selectedLabelStyle: TextStyle(
        color: EventlyColors.white,
        fontWeight: FontWeight.w700,
        fontSize: 12,
        fontFamily: "Inter",
      ),
      unselectedItemColor: EventlyColors.white,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 24,
        color: EventlyColors.white,
        fontWeight: FontWeight.w700,
        fontFamily: "Inter",
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        color: EventlyColors.white,
        fontWeight: FontWeight.w700,
        fontFamily: "Inter",
      ),
      titleSmall: TextStyle(
        fontSize: 18,
        color: EventlyColors.white,
        fontWeight: FontWeight.w700,
        fontFamily: "Inter",
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: EventlyColors.white,
        fontWeight: FontWeight.w700,
        fontFamily: "Inter",
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: EventlyColors.white,
        fontWeight: FontWeight.w700,
        fontFamily: "Inter",
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: EventlyColors.white,
        fontWeight: FontWeight.w700,
        fontFamily: "Inter",
      ),
    ),
  );
}
