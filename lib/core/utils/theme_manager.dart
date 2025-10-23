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
    ),
  );
  static ThemeData get darkThemeData => ThemeData.dark().copyWith(
    scaffoldBackgroundColor: ColorManager.scaffoldColorDark,
    textTheme: TextTheme(
      displayLarge: StylesManager.displayLargeDark,
      displayMedium: StylesManager.displayMediumDark,
      headlineSmall: StylesManager.headlineSmallDark,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.primaryColor,
        foregroundColor: Colors.white,
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    ),
  );
}
