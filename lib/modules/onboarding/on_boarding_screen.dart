import 'package:evently/core/constants/colors/evently_colors.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});
  static const String routeName = "/OnBoarding";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EventlyColors.blue,
    );
  }
}
