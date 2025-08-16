import 'package:bot_toast/bot_toast.dart';
import 'package:evently/core/constants/theme/evently_theme_manager.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/modules/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

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
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: const MyApp(),
    ),
  );

  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: provider.currentThemeMode,
      theme: EventlyThemeManager.eventlyThemeData,
      darkTheme: EventlyThemeManager.eventlyDarkThemeData,
      initialRoute: PageRoutesName.splash,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      locale: Locale(provider.currentLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: EasyLoading.init(builder: BotToastInit()),
    );
  }
}
