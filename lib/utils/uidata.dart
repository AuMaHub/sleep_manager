import 'package:flutter/material.dart';

class UIData {
  static Color black = const Color(0xff121212);
  static ThemeData darkTheme = ThemeData(
      accentColor: UIData.black,
      brightness: Brightness.dark,
      primaryColor: Color(0xff000000),
      backgroundColor: Color(0xffffffff));

  static ThemeData lightTheme = ThemeData(
    primaryColorDark: Color(0xffbb86fc),
    brightness: Brightness.light,
    primaryColor: Colors.blue,
  );
}
