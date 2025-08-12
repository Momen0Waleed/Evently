import 'package:evently/core/routes/page_routes_name.dart';
import 'package:evently/modules/authentication/create_account.dart';
import 'package:evently/modules/authentication/forget_password_screen.dart';
import 'package:evently/modules/authentication/login_screen.dart';
import 'package:evently/modules/layout/layout_view.dart';
import 'package:evently/modules/onboarding/first_settings_screen.dart';
import 'package:evently/modules/onboarding/on_boarding_screen.dart';
import 'package:evently/modules/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../modules/event_creation/create_event_view.dart';

abstract class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageRoutesName.splash:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
          settings: settings,
        );
      case PageRoutesName.onboarding:
        return MaterialPageRoute(
          builder: (_) => OnBoardingScreen(),
          settings: settings,
        );
      case PageRoutesName.firstOnboarding:
        return MaterialPageRoute(
          builder: (_) => FirstSettingsScreen(),
          settings: settings,
        );
      case PageRoutesName.login:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
          settings: settings,
        );
      case PageRoutesName.register:
        return MaterialPageRoute(
          builder: (_) => CreateAccount(),
          settings: settings,
        );
      case PageRoutesName.forgetPassword:
        return MaterialPageRoute(
          builder: (_) => ForgetPasswordScreen(),
          settings: settings,
        );
      case PageRoutesName.layout:
        return MaterialPageRoute(
          builder: (_) => LayoutView(),
          settings: settings,
        );
      case PageRoutesName.eventCreation:
        return MaterialPageRoute(
          builder: (_) => CreateEventView(),
          settings: settings,
        );
        
      default: return MaterialPageRoute(builder: (_) => SplashScreen(),settings: settings);
    }
  }
}
