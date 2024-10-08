import 'package:flutter/material.dart';

enum StyleEnum { h26, h24, h22, h20, p18, p16, p14, p12, p11, custom }

class CustomText extends StatelessWidget {
  const CustomText._(
    this.text, {
    Key? key,
    this.color,
    this.textDecoration,
    this.textStyle,
    required this.enumStyle,
    this.textAlign,
  }) : super(key: key);

  final String text;
  final StyleEnum enumStyle;
  final Color? color;
  final TextDecoration? textDecoration;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  factory CustomText.h26(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
  }) {
    return CustomText._(text,
        key: key, color: color, textAlign: textAlign, enumStyle: StyleEnum.h26);
  }

  factory CustomText.h24(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
  }) {
    return CustomText._(text,
        key: key, color: color, textAlign: textAlign, enumStyle: StyleEnum.h24);
  }
  factory CustomText.h22(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
  }) {
    return CustomText._(text,
        key: key, color: color, textAlign: textAlign, enumStyle: StyleEnum.h22);
  }
  factory CustomText.h20(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
  }) {
    return CustomText._(text,
        key: key, color: color, textAlign: textAlign, enumStyle: StyleEnum.h20);
  }

  factory CustomText.p18(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
  }) {
    return CustomText._(text,
        key: key, color: color, textAlign: textAlign, enumStyle: StyleEnum.p18);
  }

  factory CustomText.p16(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    TextDecoration? textDecoration,
  }) {
    return CustomText._(text,
        key: key,
        color: color,
        textAlign: textAlign,
        textDecoration: textDecoration,
        enumStyle: StyleEnum.p16);
  }

  factory CustomText.p14(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    TextDecoration? textDecoration,
  }) {
    return CustomText._(
      text,
      key: key,
      color: color,
      textAlign: textAlign,
      textDecoration: textDecoration,
      enumStyle: StyleEnum.p14,
    );
  }
  factory CustomText.p12(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
  }) {
    return CustomText._(text,
        key: key, color: color, textAlign: textAlign, enumStyle: StyleEnum.p12);
  }
  factory CustomText.p11(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
  }) {
    return CustomText._(text,
        key: key, color: color, textAlign: textAlign, enumStyle: StyleEnum.p11);
  }

  factory CustomText.custom(String text, TextStyle style) {
    return CustomText._(
      text,
      enumStyle: StyleEnum.custom,
      textStyle: style,
    );
  }

  static TextStyle? styleOf(BuildContext context, StyleEnum enumStyle) {
    switch (enumStyle) {
      case StyleEnum.h26:
        return Theme.of(context).textTheme.headlineSmall;
      case StyleEnum.h24:
        return Theme.of(context).textTheme.headlineSmall;
      case StyleEnum.h22:
        return Theme.of(context).textTheme.headlineMedium;
      case StyleEnum.h20:
        return Theme.of(context).textTheme.headlineMedium;
      case StyleEnum.p18:
        return Theme.of(context).textTheme.titleLarge;
      case StyleEnum.p16:
        return Theme.of(context).textTheme.titleSmall;
      case StyleEnum.p14:
        return Theme.of(context).textTheme.bodyMedium;
      case StyleEnum.p12:
        return Theme.of(context).textTheme.bodyMedium;
      case StyleEnum.p11:
        return Theme.of(context).textTheme.bodySmall;
      case StyleEnum.custom:
        // TODO: Handle this case.
    }
  }

  @override
  Widget build(BuildContext context) {
    final _style = styleOf(context, enumStyle);
    return Text(
      text,
      style: textStyle ??
          _style!.copyWith(color: color, decoration: textDecoration),
      textAlign: textAlign,
    );
  }
}
