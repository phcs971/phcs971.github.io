import 'package:flutter/material.dart';

class AppColors {
  static const blue = MaterialColor(0xFF000020, {
    900: Color(0xFF000020),
    800: Color(0xFF232641),
    700: Color(0xFF414360),
    600: Color(0xFF535573),
    500: Color(0xFF7A7B9B),
    400: Color(0xFF9C9DBF),
    300: Color(0xFFC2C3E6),
    200: Color(0xFFD7D8FB),
    100: Color(0xFFE6E7FF),
    50: Color(0xFFF2F3FF),
  });

  static final gradient = RadialGradient(
    colors: [
      AppColors.blue.shade800,
      AppColors.blue,
    ],
  );

  static const white = Color(0xFFFBFAF8);
  static const yellow = Color(0xFFFF9300);
  static const orange = Color(0xFFC1340A);
  static const green = Color(0xFF698F3F);
}
