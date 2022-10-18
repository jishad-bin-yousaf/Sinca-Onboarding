import 'package:flutter/material.dart';

class MyThemes {
  static ThemeData darkTheme() {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Color.fromARGB(255, 28, 28, 28),
    );
  }

  static ThemeData lightTheme() {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
    );
  }
}
