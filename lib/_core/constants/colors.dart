import 'package:flutter/material.dart';

sealed class ColorsApp {
  static final colorScheme = ColorScheme.fromSeed(
    seedColor: ColorsApp.black,
    brightness: Brightness.dark,
  );
  static final black = const Color(0xFF121312);
  static final darkGreen = const Color(0xFF282a28);
  static final lightBlack = const Color(0x1F000000);
  static final yellow = const Color(0xFFffbb3b);
  static final white = const Color(0xFFffffff);
  static final green = const Color(0xFF57aa53);
  static final red = const Color(0xFFe82626);
  static final red2 = const Color(0xFFE82626);
  static final gray = const Color(0xFF212121);
  static final transparent = const Color(0x00000000);
}
