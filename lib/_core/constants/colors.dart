import 'package:flutter/material.dart';

sealed class ColorsApp {
  static final colorScheme = ColorScheme.fromSeed(
    seedColor: ColorsApp.black,
    brightness: Brightness.dark,
  );
  static final black = const Color(0xFF121312);
  static final darkGreen = const Color(0xFF282a28);
  static final yellow = const Color(0xFFffbb3b);
  static final white = const Color(0xFFffffff);
  static final green = const Color(0xFF57aa53);
  static final red = const Color(0xFFe82626);
}
