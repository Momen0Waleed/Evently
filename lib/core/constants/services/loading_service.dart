import 'package:evently/core/constants/colors/evently_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void configLoading(){
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 20.0
    ..progressColor = Colors.yellow
    ..backgroundColor = EventlyColors.blue
    ..indicatorColor = EventlyColors.white
    ..textColor = EventlyColors.white
    // ignore: deprecated_member_use
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
    // ..customAnimation = CustomAnimation();
}