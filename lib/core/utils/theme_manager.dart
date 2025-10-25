import 'package:flutter/material.dart';
import 'package:taska/core/utils/color_manager.dart';
import 'package:taska/core/utils/styles_manager.dart';

abstract class ThemeManager {
  static ThemeData get lightThemeData => ThemeData.light().copyWith(
    scaffoldBackgroundColor: ColorManager.scaffoldColorLight,
    textTheme: TextTheme(
      displayLarge: StylesManager.displayLargeLight,
      displayMedium: StylesManager.displayMediumLight,
      headlineSmall: StylesManager.headlineSmallLight,
      labelSmall: StylesManager.labelSmallLight,
      headlineMedium: StylesManager.headlineMediumLight,
      bodySmall: StylesManager.bodySmallLight,
      bodyLarge: const TextStyle(color: Colors.black),
      titleMedium: StylesManager.titleMediumLight,
      displaySmall: StylesManager.displaySmallLight,
      titleSmall: StylesManager.titleSmallLight,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.primaryColor,
        foregroundColor: Colors.white,
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.borderColor),
      ),
      hintStyle: StylesManager.headlineSmallLight.copyWith(
        color: ColorManager.hintColor.withOpacity(0.4),
      ),
    ),
  );
  static ThemeData get darkThemeData => ThemeData.dark().copyWith(
    scaffoldBackgroundColor: ColorManager.scaffoldColorDark,
    textTheme: TextTheme(
      displayLarge: StylesManager.displayLargeDark,
      displayMedium: StylesManager.displayMediumDark,
      headlineSmall: StylesManager.headlineSmallDark,
      labelSmall: StylesManager.labelSmallDark,
      headlineMedium: StylesManager.headlineMediumDark,
      displaySmall: StylesManager.displaySmallDark,
      titleSmall: StylesManager.titleSmallDark,
      titleMedium: StylesManager.titleMediumDark,
      labelMedium: StylesManager.labelMediumDark,
      bodySmall: StylesManager.bodySmallDark,
      bodyMedium: StylesManager.bodyMediumDark,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.primaryColor,
        foregroundColor: Colors.white,
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.borderColor),
      ),
      fillColor: ColorManager.fillColor,
      filled: true,
      hintStyle: StylesManager.headlineSmallLight.copyWith(
        color: ColorManager.hintColor,
      ),
    ),
  );
}
