import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle poppins({
    double fontSize = 14,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }
}
