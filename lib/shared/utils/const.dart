import 'package:flutter/material.dart';

class Constants {
  static String appName = "Live Planer";

  static Color primary = Colors.black;
  static Color text = Colors.white;
  static Color accent = const Color(0xff5563ff);
  static Color background = Colors.black;

  static ThemeData theme = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          primary: primary,
          secondary: accent,
          surface: background,
          seedColor: accent),
      textTheme: const TextTheme(
          displayLarge: TextStyle(
        fontSize: 26,
      )));
}
