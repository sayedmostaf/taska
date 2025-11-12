import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taska/core/utils/color_manager.dart';

abstract class StylesManager {
  // Display styles - Large, impactful text
  static TextStyle get displayLargeDark => GoogleFonts.cairo(
    color: Colors.white,
    fontSize: 48.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );
  static TextStyle get displayLargeLight => GoogleFonts.cairo(
    color: Colors.black,
    fontSize: 48.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );

  // Display Medium - Subheadings
  static TextStyle get displayMediumDark => GoogleFonts.cairo(
    color: Colors.white.withOpacity(0.87),
    fontSize: 36.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
  );
  static TextStyle get displayMediumLight => GoogleFonts.cairo(
    color: Colors.black.withOpacity(0.87),
    fontSize: 36.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
  );

  // Display Small - Section headers
  static TextStyle get displaySmallDark => GoogleFonts.cairo(
    color: Colors.white.withOpacity(0.87),
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );
  static TextStyle get displaySmallLight => GoogleFonts.cairo(
    color: Colors.black.withOpacity(0.87),
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );

  // Headline styles - Important content
  static TextStyle get headlineMediumDark => GoogleFonts.cairo(
    color: Colors.white.withOpacity(0.87),
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );
  static TextStyle get headlineMediumLight => GoogleFonts.cairo(
    color: Colors.black.withOpacity(0.87),
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );
  static TextStyle get headlineSmallDark => GoogleFonts.cairo(
    color: Colors.white.withOpacity(0.87),
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );
  static TextStyle get headlineSmallLight => GoogleFonts.cairo(
    color: Colors.black.withOpacity(0.87),
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );

  // Title styles - Card and list titles
  static TextStyle get titleMediumDark => GoogleFonts.cairo(
    color: Colors.white.withOpacity(0.87),
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );
  static TextStyle get titleMediumLight => GoogleFonts.cairo(
    color: Colors.black.withOpacity(0.87),
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );
  static TextStyle get titleSmallDark => GoogleFonts.cairo(
    color: Colors.white.withOpacity(0.87),
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );
  static TextStyle get titleSmallLight => GoogleFonts.cairo(
    color: Colors.black.withOpacity(0.87),
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  // Body styles - Main content text
  static TextStyle get bodyMediumDark => GoogleFonts.cairo(
    color: Colors.white.withOpacity(0.87),
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );
  static TextStyle get bodyMediumLight => GoogleFonts.cairo(
    color: Colors.black.withOpacity(0.87),
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );
  static TextStyle get bodySmallDark => GoogleFonts.cairo(
    color: Colors.white.withOpacity(0.87),
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );
  static TextStyle get bodySmallLight => GoogleFonts.cairo(
    color: Colors.black.withOpacity(0.87),
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  // Label styles - UI elements and captions
  static TextStyle get labelMediumDark => GoogleFonts.cairo(
    color: const Color(0xFFAFAFAF),
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );
  static TextStyle get labelMediumLight => GoogleFonts.cairo(
    color: const Color(0xFFAFAFAF),
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );
  static TextStyle get labelSmallDark => GoogleFonts.cairo(
    color: ColorManager.borderColorDark,
    fontSize: 12.sp,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.5,
  );
  static TextStyle get labelSmallLight => GoogleFonts.cairo(
    color: ColorManager.borderColor,
    fontSize: 12.sp,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.5,
  );
}
