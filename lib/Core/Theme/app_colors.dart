import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color.fromRGBO(2, 195, 94, 1);
  static const Color secondary = Color.fromRGBO(1, 174, 178, 1);
  static const Color accent = Color(0xFF80CBC4);

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color greyLight = Color(0xFFF5F5F5);
  static const Color greyDark = Color(0xFF757575);

  static const Color background = Color(0xFFF0F4F8);

  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFC107);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      primary,
      secondary,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
