import 'dart:math';

import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color_scheme.dart';

class AppTheme {
  final AppColorScheme appColorScheme;

  AppTheme(this.appColorScheme);

  ThemeData getThemeData(BuildContext context) {
     final popinsFamily = GoogleFonts.poppins().fontFamily;
     final cairoFamily = GoogleFonts.cairo().fontFamily;
     TextTheme enTextTheme = TextTheme(
      displayLarge: TextStyle(
          fontSize: 24.sp, fontFamily: popinsFamily, fontWeight: FontWeight.w600),
      displayMedium: TextStyle(
          fontSize: 20.sp, fontFamily: popinsFamily, fontWeight: FontWeight.w600),
      displaySmall: TextStyle(
          fontSize: 18.sp, fontFamily: popinsFamily, fontWeight: FontWeight.w600),
      headlineMedium: TextStyle(
          fontSize: 16.sp, fontFamily: popinsFamily, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(
          fontSize: 17.sp, fontFamily: popinsFamily, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(
          fontSize: 12.sp, fontFamily: popinsFamily, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(
          fontSize: 16.sp, fontFamily: popinsFamily, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(
          fontFamily: popinsFamily, fontSize: 14.sp, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(
          fontFamily: popinsFamily, fontSize: 14.sp, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(
          fontFamily: popinsFamily, fontSize: 12.sp, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(
        fontFamily: popinsFamily,
        fontSize: 12.sp,
      ),
      labelSmall: TextStyle(
        fontFamily: popinsFamily,
        fontSize: 10.sp,
      ),
      labelMedium: TextStyle(
        fontFamily: popinsFamily,
        fontSize: 12.sp,
      ),
      labelLarge: TextStyle(
        fontFamily: popinsFamily,
        fontSize: 16.sp,
      ),
    );
     TextTheme arTextTheme = TextTheme(
      displayLarge: TextStyle(
          fontSize: 24.sp, fontFamily: cairoFamily, fontWeight: FontWeight.w600),
      displayMedium: TextStyle(
          fontSize: 20.sp, fontFamily: cairoFamily, fontWeight: FontWeight.w600),
      displaySmall: TextStyle(
          fontSize: 18.sp, fontFamily: cairoFamily, fontWeight: FontWeight.w600),
      headlineMedium: TextStyle(
          fontSize: 16.sp, fontFamily: cairoFamily, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(
          fontSize: 17.sp, fontFamily: cairoFamily, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(
          fontSize: 12.sp, fontFamily: cairoFamily, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(
          fontSize: 16.sp, fontFamily: cairoFamily, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(
          fontFamily: cairoFamily, fontSize: 14.sp, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(
          fontFamily: cairoFamily, fontSize: 14.sp, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(
          fontFamily: cairoFamily, fontSize: 12.sp, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(
          fontFamily: cairoFamily,
          fontSize: 12.sp,
          color: HexColor.fromHex('#76738F')),
      labelSmall: TextStyle(
        fontFamily: cairoFamily,
        fontSize: 10.sp,
      ),
      labelLarge: TextStyle(
        fontFamily: cairoFamily,
        fontSize: 16.sp,
      ),
    );
    return ThemeData(
      primaryColor: appColorScheme.primaryColor,
      primarySwatch: _generateMaterialColor(),
      brightness: context.isDark ? Brightness.dark : Brightness.light,

      scaffoldBackgroundColor: appColorScheme.backgroundColor,
      cardColor: appColorScheme.cardBackgroundColor,
      dialogBackgroundColor: appColorScheme.backgroundColor,
      canvasColor: appColorScheme.backgroundAccentColor,
      focusColor: appColorScheme.infoTextColor,
      dividerColor: appColorScheme.dividerColor,
      hintColor: appColorScheme.placeholderColor,
      indicatorColor: appColorScheme.accentColor,
      disabledColor: appColorScheme.placeholderColor,
      dialogTheme: DialogTheme(
          backgroundColor: appColorScheme.backgroundColor,
          surfaceTintColor: appColorScheme.backgroundColor),
      bottomSheetTheme:
          BottomSheetThemeData(backgroundColor: appColorScheme.backgroundColor),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: appColorScheme.accentColor,
      ),
      iconTheme: IconThemeData(color: appColorScheme.iconTintColor),
      primaryIconTheme: IconThemeData(color: appColorScheme.iconTintColor),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: appColorScheme.accentColor,
      ),
      appBarTheme: AppBarTheme(
        elevation: 1,
        backgroundColor: appColorScheme.appBarBackgroundColor,
        titleTextStyle: TextStyle(color: appColorScheme.primaryFontColor),
        surfaceTintColor: appColorScheme.appBarBackgroundColor,
        iconTheme: IconThemeData(color: appColorScheme.appBarIconColor),
      ),
      textTheme: context.isArabic
          ? arTextTheme.apply(
              displayColor: appColorScheme.primaryFontColor,
              bodyColor: appColorScheme.primaryFontColor,
            )
          : enTextTheme.apply(
              displayColor: appColorScheme.primaryFontColor,
              bodyColor: appColorScheme.primaryFontColor,
            ),
      fontFamily: context.locale.languageCode == "en"
          ? popinsFamily
          : cairoFamily,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: appColorScheme.secondaryFontColor),
        hintStyle: TextStyle(color: appColorScheme.placeholderColor),
        fillColor: appColorScheme.cardBackgroundColor,
        filled: true,
        prefixIconColor: appColorScheme.iconTintColor,
        suffixIconColor: appColorScheme.iconTintColor,
        iconColor: appColorScheme.iconTintColor,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: appColorScheme.inputBorderColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: appColorScheme.inputBorderColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: appColorScheme.inputBorderColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: appColorScheme.inputBorderColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 7, 14, 7),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(vertical: 17.h, horizontal: 16.w)),
          overlayColor:
              WidgetStateProperty.all(appColorScheme.elevatedButtonTextColor),
          foregroundColor:
              WidgetStateProperty.all(appColorScheme.elevatedButtonTextColor),
          surfaceTintColor:
              WidgetStateProperty.all(appColorScheme.elevatedButtonTextColor),
          backgroundColor:
              WidgetStateProperty.all(appColorScheme.buttonBackgroundColor),
          elevation: WidgetStateProperty.all(1),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(vertical: 17.h, horizontal: 16.w)),
          overlayColor: WidgetStateProperty.all(
              appColorScheme.primaryColor.withAlpha(50)),
          foregroundColor: WidgetStateProperty.all(appColorScheme.primaryColor),
          backgroundColor:
              WidgetStateProperty.all(appColorScheme.backgroundColor),
          elevation: WidgetStateProperty.all(1),
          side: WidgetStateProperty.all(
              BorderSide(color: appColorScheme.primaryColor)),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
            side: BorderSide(color: appColorScheme.primaryColor),
            borderRadius: BorderRadius.circular(27),
          )),
          textStyle: WidgetStateProperty.all(TextStyle(
            color: appColorScheme.outlineButtonTextColor,
            fontSize: 14.sp,
          )),
        ),
      ),
      cardTheme: CardTheme(
        color: appColorScheme.cardBackgroundColor,
        surfaceTintColor: appColorScheme.cardBackgroundColor,
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        overlayColor:
            WidgetStateProperty.all(appColorScheme.primaryColor.withAlpha(50)),
      )),
      unselectedWidgetColor: appColorScheme.infoTextColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: appColorScheme.backgroundColor,
          showUnselectedLabels: true,
          selectedItemColor: appColorScheme.primaryColor,
          unselectedItemColor: appColorScheme.iconTintColor,
          unselectedLabelStyle: TextStyle(fontSize: 10.sp),
          selectedLabelStyle: TextStyle(fontSize: 9.sp)),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: appColorScheme.primaryFontColor,
        labelColor: appColorScheme.primaryTabBarLabelColor,
        overlayColor: WidgetStateProperty.all(
            appColorScheme.primaryColor.withOpacity(0.1)),
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
              color: appColorScheme.primaryTabBarLabelColor, width: 2.h),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppMaterialColors.green.shade200,
      ),
    );
  }

  MaterialColor _generateMaterialColor() {
    return MaterialColor(appColorScheme.primaryColor.value, {
      50: _tintColor(appColorScheme.secondaryColor, 0.9),
      100: _tintColor(appColorScheme.secondaryColor, 0.8),
      200: _tintColor(appColorScheme.secondaryColor, 0.6),
      300: _tintColor(appColorScheme.secondaryColor, 0.4),
      400: _tintColor(appColorScheme.secondaryColor, 0.2),
      500: appColorScheme.accentColor,
      600: _shadeColor(appColorScheme.primaryColor, 0.1),
      700: _shadeColor(appColorScheme.primaryColor, 0.2),
      800: _shadeColor(appColorScheme.primaryColor, 0.3),
      900: _shadeColor(appColorScheme.primaryColor, 0.4),
    });
  }

  int _tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  Color _tintColor(Color color, double factor) => Color.fromRGBO(
      _tintValue(color.red, factor),
      _tintValue(color.green, factor),
      _tintValue(color.blue, factor),
      1);

  int _shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  Color _shadeColor(Color color, double factor) => Color.fromRGBO(
      _shadeValue(color.red, factor),
      _shadeValue(color.green, factor),
      _shadeValue(color.blue, factor),
      1);
}

ThemeData getDatePickerTheme(context) {
  return Theme.of(context).copyWith(
    colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: Theme.of(context).colorScheme.secondary,
        onSurface: Theme.of(context).textTheme.bodyLarge!.color),
  );
}
