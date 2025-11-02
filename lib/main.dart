import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/cache/cache_helper.dart';
import 'package:taska/core/cache/cache_keys_values.dart';
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
    CacheData.cacheIntialization(),
    EasyLocalization.ensureInitialized(),
  ]);
  setupLocator();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) {
        return EasyLocalization(
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
        );
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          );
        },
      ),
    );
  }
}
