import 'package:dawaa24/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/failures/field_failure/field_failure.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField({
    Key? key,
    required this.hintText,
    this.title,
    this.initValue,
    this.prefixIcon,
    this.prefix,
    this.suffixIcon,
    this.suffix,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
    this.autoValidate = true,
    this.onChange,
    this.onTap,
    this.textInputAction,
    this.fillColor,
    this.textInputType,
    this.suffixText,
    this.prefixIconWidth,
    this.readOnly = false,
    this.hintStyle,
    this.maxLines = 1,
    this.boarderRadius,
    this.borderColor,
    this.titleColor,
    this.inputFormatters,
    this.maxLength,
  }) : super(key: key);

  final bool autoValidate;
  final TextInputType? textInputType;
  final int maxLines;
  final String? initValue;
  final Widget? prefix;
  final Widget? suffix;
  final String hintText;
  final String? title;
  final Color? titleColor;
  final Color? borderColor;
  final Widget? suffixIcon;
  final String? suffixText;
  final Widget? prefixIcon;
  final double? prefixIconWidth;
  final double? boarderRadius;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final FieldFailure? Function(String)? validator;
  final bool isPassword;
  final Function()? onTap;
  final bool readOnly;
  final Color? fillColor;
  final TextInputAction? textInputAction;
  final TextStyle? hintStyle;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Column(
            children: [
              Text(
                widget.title!,
                style: TextStyle(
                  color: widget.titleColor ?? Colors.grey.shade400,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
            ],
          ),
          TextFormField(
          initialValue: widget.initValue,
          onTap: widget.onTap,
          maxLines: widget.maxLines,
          minLines: 1,
          expands: false,
          scrollPadding: const EdgeInsets.all(10.0),
          validator: widget.validator != null
              ? (value) {
                  return context
                      .fieldFailureParser(widget.validator!(value ?? ''));
                }
              : null,
          readOnly: widget.readOnly,
          onChanged: widget.onChange,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          autovalidateMode: widget.autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          obscureText: widget.isPassword,
          inputFormatters: widget.inputFormatters,
          maxLength: widget.maxLength,
          decoration: InputDecoration(
            hintText: widget.hintText,
            fillColor: widget.fillColor,
            hintStyle: widget.hintStyle,
            suffixText: widget.suffixText,
            suffixIcon: widget.suffix,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.borderColor ?? const Color(0xffc1c7D0),
                ),
                borderRadius: BorderRadius.circular(widget.boarderRadius ?? 0)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.borderColor ?? const Color(0xffc1c7D0),
              ),
              borderRadius: BorderRadius.circular(widget.boarderRadius ?? 0),
            ),
            prefixIcon: widget.prefixIcon,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 14.0, vertical: 15.0),
            prefixIconConstraints: widget.prefixIcon == null
                ? null
                : BoxConstraints(maxWidth: widget.prefixIconWidth ?? 40.0),
          ),
        )
      ],
    );
  }
}
