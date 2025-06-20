import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_flutter/_core/constants/colors.dart';

abstract final class AppStyle {
  static TextTheme textTheme = TextTheme(
    labelLarge: TextStyle(
      color: ColorsApp.white,
      fontSize: 36,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: TextStyle(
      color: ColorsApp.white,
      fontSize: 36,
      fontWeight: FontWeight.w700,
    ),
    bodyMedium: TextStyle(
      color: ColorsApp.black,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(
      color: ColorsApp.white,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: ColorsApp.white,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
    titleSmall: TextStyle(
      color: ColorsApp.yellow,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: TextStyle(
      color: ColorsApp.white,
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: TextStyle(
      color: ColorsApp.white,
      fontSize: 24,
      fontWeight: FontWeight.w500,
    ),
    headlineLarge: GoogleFonts.pacifico(fontSize: 50, color: Colors.white),
  );
}
