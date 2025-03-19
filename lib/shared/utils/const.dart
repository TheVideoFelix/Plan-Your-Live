import 'package:flutter/material.dart';

class Constants {
  static String appName = "Live Planer";

  static Color primary = const Color(0xffff0000);
  static Color text = Colors.white;
  static Color labelText = secondary;
  static Color secondary = const Color(0xff1B263B);
  static Color surfaceContainer = const Color(0x5430405E);
  static Color accent = const Color(0xffD7263D);
  static Color background = const Color(0xff0D1B2A);

  static Color todoIsChecked = Colors.white60;

  static ThemeData theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          primary: primary,
          onPrimary: accent,
          secondary: secondary,
          surface: background,
          surfaceContainer: surfaceContainer,
          seedColor: primary,),
      textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 28,
          ),
          displayMedium: const TextStyle(
            fontSize: 24,
          ),
          displaySmall: const TextStyle(fontSize: 18),

          titleMedium: const TextStyle(fontSize: 24),
          titleSmall: const TextStyle(fontSize: 20),

          bodyLarge: const TextStyle(fontSize: 20),
          bodyMedium: const TextStyle(fontSize: 18),
          bodySmall: const TextStyle(fontSize: 12),

          labelMedium: TextStyle(fontSize: 15, color: labelText),

      ));
}
