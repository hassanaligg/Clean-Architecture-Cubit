import 'package:flutter/material.dart';

class AppMaterialColors {
  static ColorScheme lightScheme = ColorScheme(
    primary: green.shade200,
    secondary: blue.shade100,
    surface: grey.shade300,
    background: white,
    error: red.shade50,
    onPrimary: const Color(0xffffffff),
    onSecondary: const Color(0xffffffff),
    onSurface: const Color(0xff000000),
    onBackground: grey.shade200,
    onError: red.shade50,
    brightness: Brightness.light,
  );
  static ColorScheme darkScheme = ColorScheme(
    primary: blue.shade300,
    secondary: blue.shade100,
    surface: grey.shade300,
    background: grey.shade200,
    error: red.shade50,
    onPrimary: const Color(0xffffffff),
    onSecondary: const Color(0xffffffff),
    onSurface: const Color(0xff000000),
    onBackground: grey.shade200,
    onError: red.shade50,
    brightness: Brightness.light,
  );
  static const MaterialColor green = MaterialColor(
    0xFF5EC4BF,
    <int, Color>{
      25: Color(0xFFD2F5F1),
      50: Color(0xFF5EC4BF),
      75: Color(0xFF47B9C4),
      100: Color(0xFF25D0BD),
      150: Color(0xFF1DA7CD),
      200: Color(0xFF008B99),
      250: Color(0xff008a99),
    },
  );
  static const MaterialColor blue = MaterialColor(
    0xFF16A3CE,
    <int, Color>{
      50: Color(0xFFE1F9FF),
      75: Color(0xffdaf5f8),
      100: Color(0xFFA4D6FF),
      150: Color(0xFFcce8eb),
      200: Color(0xFF1DB0DA),
      300: Color(0xFF1BA8CD),
      350: Color(0xff27d0be),
      400: Color(0xFF3694E0),
      500: Color(0xFF008B99),
      600: Color(0xFFDDF7F4),
    },
  );
  static const MaterialColor grey = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0xFFF4F4F4),
      75: Color(0xFFF2F2F2),
      80: Color(0xFFEFF3F5),
      85: Color(0xFFF2F6F7),
      90: Color(0xFFD2D4E2),
      100: Color(0xFFC1C7D0),
      150: Color(0xFFF2F6F7),
      200: Color(0xFFECF1FA),
      300: Color(0xFFA3A3A3),
      400: Color(0xFFC1C7D0),
      450: Color(0xFF76738F),
      500: Color(0xFF42526E),
      600: Color(0xFF08293B),
    },
  );
  static const MaterialColor white = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      75: Color(0xFFEFF3F5),
      100: Color(0xffdaf5f8)
    },
  );
  static const MaterialColor red = MaterialColor(
    0xFFFF5959,
    <int, Color>{
      50: Color(0xFFFF5959),
      100: Color(0xFFFF5955),
    },
  );
  static const MaterialColor brown = MaterialColor(
    0xFFB54747,
    <int, Color>{
      50: Color(0xFFEED175),
      100: Color(0xFFF8C097),
      200: Color(0xFFD9A883),
      300: Color(0xFFB54747),
      400: Color(0xFFCC1919),
      500: Color(0xFFDF3219),
      600: Color(0xFF95701E),
    },
  );
  static const MaterialColor yellow = MaterialColor(
    0xFFFFBF31,
    <int, Color>{
      50: Color(0xFFFFBF31),
    },
  );
  static const MaterialColor magenta = MaterialColor(
    0xFFB44BDB,
    <int, Color>{
      50: Color(0xFFB44BDB),
    },
  );
  static const MaterialColor pink = MaterialColor(
    0xFFFFA59B,
    <int, Color>{
      50: Color(0xFFFFA59B),
      100: Color(0xFFEF8B8B),
      200: Color(0xFFFF6555),
    },
  );
  static const MaterialColor orange = MaterialColor(
    0xFFF4AA16,
    <int, Color>{
      50: Color(0xFFF4AA16),
    },
  );
  static const MaterialColor black = MaterialColor(
    0xFF444444,
    <int, Color>{
      25: Color(0xFF6E7183),
      50: Color(0xff333A42),
      75: Color(0xff707070),
      100: Color(0xff1F2329),
      200: Color(0xFF000000),
    },
  );

  static const polor = Color(0xffd5f3f6);
  static const morningGlory = Color(0xff93d9e1);
}
