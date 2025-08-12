import 'package:bot_toast/bot_toast.dart';
import 'package:evently/core/constants/theme/evently_theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'core/constants/services/loading_service.dart';
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

  configLoading();

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
      builder: EasyLoading.init(builder: BotToastInit()),
    );
  }
}
