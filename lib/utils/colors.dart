// colors.dart
import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFEA4C89);
  static const Color secondaryColor = Color(0xFFF082AC);
  static const Color lightPink = Color(0xFFFFF0F5);
  static const Color darkPink = Color(0xFFC2185B);
  static const Color softPink = Color(0xFFF48FB1);
  static const Color mutedPurple = Color(0xFFCE93D8);

  static ColorScheme colorScheme = ColorScheme.light(
    primary: Color(0xFF6750A4), // Purple
    secondary: Color(0xFFEADDFF),
    surface: Color(0xFFFFFBFE),
    error: Color(0xFFB3261E),
  );
}
