import 'dart:math' as math;

import 'package:flutter/material.dart';

abstract class AppColors {
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
      50: Color(0xFF46B9C4),
      100: Color(0xFF25D0BD),
      200: Color(0xFF008B99),
      250: Color(0xFF6FC788),
      300: Color(0xFF45bc69),
    },
  );

  static LinearGradient mainGradient({double angle = 90}) {
    //convert angle from clockwise to counterclockwise
    angle = 360 - angle;
    double radian = angle * 2 * math.pi / 360;
    return LinearGradient(
      colors: [green.shade50, green.shade200],
      transform: GradientRotation(radian),
    );
  }

  static const MaterialColor blue = MaterialColor(
    0xFF16A3CE,
    <int, Color>{
      50: Color(0xFFE1F9FF),
      100: Color(0xFFA4D6FF),
      200: Color(0xFFddf7f4),
      300: Color(0xFFcce8eb),
      400: Color(0xFF1DB0DA),
      500: Color(0xFF1BA8CD),
      600: Color(0xFF3694E0),
    },
  );
  static const MaterialColor grey = MaterialColor(
    0xff959595,
    <int, Color>{
      50: Color(0xFFF4F4F4),
      100: Color(0xffA8A8A8),
      150: Color(0xffA8A8A8),
      200: Color(0xffeff3f5),
      250: Color(0xff959595),
      300: Color(0xFFECF1FA),
      400: Color(0xFFC1C7D0),
      450: Color(0xFF757575),
      500: Color(0xFF42526E),
      600: Color(0xFF08293B),
      700: Color(0xff1F2329),
    },
  );
  static const MaterialColor white = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      75: Color(0xFFF7F7F7),
    },
  );
  static const MaterialColor red = MaterialColor(
    0xFFFF5959,
    <int, Color>{
      25: Color(0xFFF5A5A5),
      50: Color(0xFFFF5959),
      100: Color(0xFFB54747),
      200: Color(0x31252599),
      500: Color(0xFFA70000),
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
    <int, Color>{50: Color(0xFFFFBF31), 100: Color(0xFFD2AA53)},
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
      75: Color(0xFF8F5CAD),
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
      50: Color(0xFF444444),
      100: Color(0xff1F2329),
      200: Color(0xFF000000),
    },
  );
}
