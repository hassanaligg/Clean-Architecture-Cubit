import 'package:flutter/material.dart';

abstract class ThemeState {

}

class ThemeInitial extends ThemeState {
   bool isDarkMode;
  ThemeInitial({required this.isDarkMode});
}

class DarkThemeState extends ThemeState {
  DarkThemeState();
}


class LightThemeState extends ThemeState {
  LightThemeState();
}


