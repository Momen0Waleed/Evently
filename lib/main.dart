import 'package:evently/core/constants/theme/evently_theme_manager.dart';
import 'package:flutter/material.dart';

import 'core/constants/services/local_storage_services.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/page_routes_name.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageServices.init();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: EventlyThemeManager.eventlyThemeData,
      initialRoute: PageRoutesName.splash,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
