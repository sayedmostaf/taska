import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/utils/color_manager.dart';
import 'package:taska/core/utils/styles_manager.dart';

abstract class ThemeManager {
  static ThemeData get lightThemeData => ThemeData.light().copyWith(
    useMaterial3: true,
    scaffoldBackgroundColor: ColorManager.scaffoldColorLight,
    colorScheme: ColorScheme.light(
      primary: ColorManager.primaryColor,
      secondary: ColorManager.primaryColorLight,
      error: ColorManager.errorColor,
      surface: ColorManager.surfaceColorLight,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onError: Colors.white,
      onSurface: Colors.black87,
    ),
    cardTheme: CardThemeData(
      color: ColorManager.surfaceColorLight,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManager.borderColor, width: 1),
      ),
    ),
    textTheme: TextTheme(
      displayLarge: StylesManager.displayLargeLight,
      displayMedium: StylesManager.displayMediumLight,
      headlineSmall: StylesManager.headlineSmallLight,
      labelSmall: StylesManager.labelSmallLight,
      headlineMedium: StylesManager.headlineMediumLight,
      bodySmall: StylesManager.bodySmallLight,
      bodyLarge: const TextStyle(color: Colors.black87),
      titleMedium: StylesManager.titleMediumLight,
      displaySmall: StylesManager.displaySmallLight,
      titleSmall: StylesManager.titleSmallLight,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        backgroundColor: ColorManager.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    iconTheme: IconThemeData(size: 24.sp, color: Colors.black87),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorManager.fillColorLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: ColorManager.borderColor, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: ColorManager.borderColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: ColorManager.primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: ColorManager.errorColor, width: 1),
      ),
      hintStyle: StylesManager.headlineSmallLight.copyWith(
        color: ColorManager.hintColor,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
    ),
    dividerTheme: DividerThemeData(
      color: ColorManager.borderColor,
      thickness: 1,
      space: 1,
    ),
  );
  static ThemeData get darkThemeData => ThemeData.dark().copyWith(
    useMaterial3: true,
    scaffoldBackgroundColor: ColorManager.scaffoldColorDark,
    colorScheme: ColorScheme.dark(
      primary: ColorManager.primaryColor,
      secondary: ColorManager.primaryColorLight,
      error: ColorManager.errorColor,
      surface: ColorManager.surfaceColorDark,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onError: Colors.white,
      onSurface: Colors.white.withOpacity(0.87),
    ),
    cardTheme: CardThemeData(
      color: ColorManager.surfaceColorDark,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManager.borderColorDark, width: 1),
      ),
    ),
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
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        backgroundColor: ColorManager.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    iconTheme: IconThemeData(
      size: 24.sp,
      color: Colors.white.withOpacity(0.87),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorManager.fillColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: ColorManager.borderColorDark, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: ColorManager.borderColorDark, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: ColorManager.primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: ColorManager.errorColor, width: 1),
      ),
      hintStyle: StylesManager.headlineSmallLight.copyWith(
        color: ColorManager.hintColorDark,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
    ),
    dividerTheme: DividerThemeData(
      color: ColorManager.borderColorDark,
      thickness: 1,
      space: 1,
    ),
  );
}
