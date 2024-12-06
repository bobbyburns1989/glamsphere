import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get glamTheme => ThemeData(
    primaryColor: Colors.pink[300],
    scaffoldBackgroundColor: Colors.black,
    fontFamily: 'Poppins',
    colorScheme: ColorScheme.dark(
      primary: Colors.pink[300]!,
      secondary: Colors.purple[300]!,
    ),
  );
}