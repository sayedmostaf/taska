import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taska/core/cache/cache_helper.dart';
import 'package:taska/core/cache/cache_keys_values.dart';
import 'package:taska/core/database/database.dart';
import 'package:taska/core/notifications/local_notification.dart';
import 'package:taska/core/utils/app_router.dart';
import 'package:taska/core/utils/service_locator.dart';
import 'package:taska/core/utils/theme_manager.dart';
import 'package:taska/firebase_options.dart';

final ValueNotifier<ThemeMode> notifier = ValueNotifier(
  CacheData.getData(key: CacheKeys.kDARKMODE) == CacheValues.LIGHT
      ? ThemeMode.light
      : ThemeMode.dark,
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    LocalNotification.init(),
    CacheData.cacheIntialization(),
    EasyLocalization.ensureInitialized(),
    Hive.initFlutter(),
    Supabase.initialize(
      url: 'https://xdqqqepegpfszivwokap.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhkcXFxZXBlZ3Bmc3ppdndva2FwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI5NzY1MjIsImV4cCI6MjA3ODU1MjUyMn0.tyxt0pt9Yq-lkDuMoZCGCSJkkAYvt9dVqTPMdtT9X38',
    ),
  ]);
  await setupDatabase();
  setupLocator();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
        Locale('fr'),
        Locale('de'),
        Locale('es'),
        Locale('hi'),
        Locale('zh'),
      ],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: LocalNotification.onActionReceivedMethod,
      onNotificationCreatedMethod:
          LocalNotification.onNotificationCreatedMethod,
      onDismissActionReceivedMethod:
          LocalNotification.onDismissActionReceivedMethod,
      onNotificationDisplayedMethod:
          LocalNotification.onNotificationDisplayedMethod,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => ValueListenableBuilder<ThemeMode>(
        valueListenable: notifier,
        builder: (context, value, child) {
          return MaterialApp.router(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.router,
            theme: ThemeManager.lightThemeData,
            darkTheme: ThemeManager.darkThemeData,
            themeMode: value,
          );
        },
      ),
    );
  }
}
