import 'package:evently/core/constants/images/images_name.dart';
import 'package:evently/core/routes/page_routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/constants/services/local_storage_keys.dart';
import '../../core/constants/services/local_storage_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigate();
    });
  }

  void _navigate() async {
    final hasSeenOnboarding = LocalStorageServices.getBool(
        LocalStorageKeys.onboardingSeenKey) ?? false;
    await Future.delayed(Duration(seconds: 2));

    if (!mounted) return;

    final user = FirebaseAuth.instance.currentUser;

    if (!hasSeenOnboarding) {
      Navigator.pushReplacementNamed(context, PageRoutesName.firstOnboarding);
    } else if (user == null) {
      Navigator.pushReplacementNamed(context, PageRoutesName.login);
    } else {
      Navigator.pushReplacementNamed(context, PageRoutesName.layout);
    }

    // Navigator.pushReplacementNamed(
    //   context,
    //   hasSeenOnboarding ? PageRoutesName.login :
    //   PageRoutesName.firstOnboarding,
    // );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
          alignment: Alignment.center,
          child: Image.asset(ImagesName.splashLogo,fit: BoxFit.cover,width: MediaQuery.of(context).size.width * 0.3,)),
    );
  }
}