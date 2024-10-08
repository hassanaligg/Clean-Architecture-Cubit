import 'package:dawaa24/core/presentation/resources/theme/app_color.dart';
import 'package:flutter/material.dart';

abstract class AppColorScheme {
  Color get primaryColor => AppColors.green.shade200;

  Color get secondaryColor;

  Color get accentColor => const Color(0xFF008B99);

  Color get errorColor => const Color(0xffff5959);

  Color get placeholderColor;

  Color get inputBorderColor;

  Color get dividerColor;

  Color get primaryFontColor;

  Color get primaryTabBarLabelColor;

  Color get secondaryFontColor;

  Color get cardBackgroundColor;

  Color get backgroundColor;

  Color get appBarBackgroundColor;

  Color get backgroundAccentColor;

  Color get iconTintColor;

  Color get buttonBackgroundColor;

  Color get elevatedButtonTextColor;

  Color get outlineButtonTextColor;

  Color get appBarIconColor;

  Color get fieldBackgroundColor => const Color(0xFF42526E);

  Color get secondaryCardBackgroundColor;

  Color get infoTextColor;
}

class AppDarkColorScheme extends AppColorScheme {
  @override
  Color get backgroundColor => const Color(0xff333a42);

  @override
  Color get appBarBackgroundColor => const Color(0xff333a42);

  @override
  Color get buttonBackgroundColor => const Color(0xff25D0BD);

  @override
  Color get elevatedButtonTextColor => const Color(0xffFFFFFF);

  @override
  Color get outlineButtonTextColor => const Color(0xffFFFFFF);

  @override
  Color get cardBackgroundColor => const Color(0xff1f2329);

  @override
  Color get secondaryCardBackgroundColor => const Color(0xff333a42);

  @override
  Color get dividerColor => Color(0xfff2f6f7);

  @override
  Color get iconTintColor => const Color(0xffffffff);

  @override
  Color get inputBorderColor => const Color(0xff1f2329);

  @override
  Color get placeholderColor => const Color(0xffc1c7D0);

  // @override
  // Color get primaryColor => const Color(0xFFFFFFFF);

  @override
  Color get primaryFontColor => const Color(0xffffffff);

  @override
  Color get secondaryColor => const Color(0xff00dcaf);

  @override
  Color get secondaryFontColor => const Color(0xffeff3f5);

  @override
  Color get infoTextColor => const Color(0xff979797);

  @override
  Color get appBarIconColor => const Color(0xffffffff);

  @override
  Color get backgroundAccentColor => const Color(0xff1f2329);

  @override
  Color get primaryTabBarLabelColor => const Color(0xff47B9C4);
}

class AppLightColorScheme extends AppColorScheme {
  @override
  Color get backgroundColor => const Color(0xffFFFFFF);

  @override
  Color get appBarBackgroundColor => const Color(0xffffffff);

  @override
  Color get buttonBackgroundColor => const Color(0xff25D0BD);

  @override
  Color get elevatedButtonTextColor => const Color(0xffFFFFFF);

  @override
  Color get outlineButtonTextColor => const Color(0xff008b99);

  @override
  Color get cardBackgroundColor => const Color(0xffffffff);

  @override
  Color get secondaryCardBackgroundColor => const Color(0xffededed);

  @override
  Color get dividerColor => Colors.grey;

  @override
  Color get iconTintColor => const Color(0xff6e7183);

  @override
  Color get inputBorderColor => const Color(0xffc1c7D0);

  @override
  Color get placeholderColor => const Color(0xffc1c7D0);

  // @override
  // Color get primaryColor => const Color(0xFFFFFFFF);

  @override
  Color get primaryFontColor => const Color(0xff000000);

  @override
  Color get secondaryColor => const Color(0xff00dcaf);

  @override
  Color get secondaryFontColor => const Color(0xff000000);

  @override
  Color get infoTextColor => const Color(0xff979797);

  @override
  Color get appBarIconColor => const Color(0xff000000);

  @override
  Color get backgroundAccentColor => const Color(0xffECF1FA);

  @override
  Color get primaryTabBarLabelColor => const Color(0xff47B9C4);
}
