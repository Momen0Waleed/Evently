import 'package:evently/core/constants/theme/evently_theme_manager.dart';
import 'package:evently/modules/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import 'core/constants/services/local_storage_services.dart';
import 'modules/home/home_screen.dart';
import 'modules/onboarding/first_settings_screen.dart';
import 'modules/onboarding/on_boarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageServices.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: EventlyThemeManager.eventlyThemeData,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName : (context) =>const SplashScreen(),
        HomeScreen.routeName : (context) =>const HomeScreen(),
        OnBoardingScreen.routeName : (context) =>const OnBoardingScreen(),
        FirstSettingsScreen.routeName : (context) =>const FirstSettingsScreen(),
      },
    );
  }
}
