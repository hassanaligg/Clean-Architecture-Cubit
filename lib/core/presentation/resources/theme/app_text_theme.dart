import 'package:dawaa24/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

///Fonts documentation:
///
/// to access the styles you should use:
///   [ context.textTheme.displayLarge ]
///   or
///   [ theme.of(context).textTheme.displayLarge ]
///
/// for [ SemiBold ] fonts you should use :
///  [ displayLarge ] => [ 24 ]
///  [ displayMedium ] => [ 20 ]
///  [ displaySmall ] => [ 18 ]
///  [ headlineMedium ] => [ 16 ]
///  [ headlineSmall ] => [ 17 ]
///  [ titleLarge ] => [ 12 ]
///
///  for [ Medium ] fonts you should use :
///  [ titleMedium ] => [ 16 ]
///  [ titleSmall ] => [ 14 ]
///
///  for [ Regular ] fonts you should use :
///  [ bodyLarge ] => [ 16 ]
///  [ bodyMedium ] => [ 14 ]
///
///  for [ Font Size 12 ] fonts you should use :
///  [ bodySmall ] => [ 12 ] and weight is medium
///
///  for [ Font Size 10 ] fonts you should use :
///  [ labelSmall ] => [ 10 ]  and weight is medium
///
/// In case of changes you should use [ copyWith ] to achieve wanted results

class AppTextTheme {
  static final popinsFamily = GoogleFonts.poppins().fontFamily;
  static final cairoFamily = GoogleFonts.cairo().fontFamily;
  static TextTheme enTextTheme = TextTheme(
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
  static TextTheme arTextTheme = TextTheme(
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
}
