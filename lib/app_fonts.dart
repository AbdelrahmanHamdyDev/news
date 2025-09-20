import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static TextStyle headlineLarge = GoogleFonts.merriweather(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle headlineMedium = GoogleFonts.merriweather(
    fontSize: 14.sp,
    fontWeight: FontWeight.w300,
  );

  static TextStyle bodyLarge = GoogleFonts.robotoCondensed(
    fontSize: 16.sp,
    height: 1.5,
  );

  static TextStyle bodyMedium = GoogleFonts.robotoCondensed(fontSize: 14.sp);
}
