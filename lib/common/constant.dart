import 'package:flutter/material.dart';

class AppFontSize {
  AppFontSize._();

  static const double xs = 10.0;   // Very small hint
  static const double sm = 12.0;   // Caption
  static const double md = 14.0;   // Secondary text
  static const double lg = 16.0;   // Body text (default)
  static const double xl = 18.0;   // Title
  static const double xxl = 22.0;  // Big heading
  static const double display = 26.0; // Screen title
}

class SpacingConst {
  SpacingConst._();

  static const double extraSmall = 4.0;
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
}


class AppPalette {
  AppPalette._();

  static const Color primaryBlue = Color(0xFF2979FF);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  static const Color grey = Color(0xFF9E9E9E);
  static const Color lightGrey = Color(0xFFE0E0E0);

  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);

  static const Color background = Color(0xFFF5F5F5);
}