import 'dart:ui';

import 'package:dawaa24/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/failures/field_failure/field_failure.dart';

class CustomTextFiled extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? textInputType;
  final Widget? prefixIcon;
  final TextStyle? hintStyle;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final bool obscureText;
  final int? maxLines;
  final FieldFailure? Function(String)? validator;
  bool? enable;
  String? label;
  TextStyle? labelStyle;
  final void Function(String)? onChanged;

  CustomTextFiled(
      {Key? key,
      this.controller,
      this.hintText,
      this.enable = true,
      this.prefixIcon,
      this.onChanged,
      this.fillColor,
      this.maxLines,
      this.textInputAction,
      this.hintStyle,
      this.textInputType,
      this.labelStyle,
      this.obscureText = false,
      this.validator,
      this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Column(
                children: [
                  Text(
                    label!,
                    style: labelStyle ?? Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(
                    height: 5.h,
                  )
                ],
              )
            : Container(),
        TextFormField(
          style: TextStyle(color: context.isDark ? Colors.white : Colors.black),
          enabled: enable,
          obscureText: obscureText,
          textInputAction: textInputAction ?? TextInputAction.next,
          keyboardType: textInputType,
          controller: controller,
          maxLines: maxLines ?? 1,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            fillColor: fillColor,
            hintStyle: hintStyle,
            prefixIcon: prefixIcon,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 14.w, vertical: 15.h),
            prefixIconConstraints:
                prefixIcon == null ? null : BoxConstraints(maxWidth: 40.w),
          ),
        ),
      ],
    );
  }
}
