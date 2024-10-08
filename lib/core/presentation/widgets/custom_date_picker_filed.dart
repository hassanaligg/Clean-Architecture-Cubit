import 'package:dawaa24/core/presentation/resources/assets.gen.dart';
import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';
import 'package:dawaa24/core/presentation/widgets/svg_icon.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/features/auth/presentation/widgets/custom_text_filed.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDatePickerFiled extends StatefulWidget {
  final TextEditingController controller;
  String hintText;
  DateTime? firstDate;
  DateTime? lastDate;

  CustomDatePickerFiled({
    super.key,
    required this.controller,
    this.hintText = "DD/MM/YYYY",
    this.firstDate,
  });

  @override
  State<CustomDatePickerFiled> createState() => _CustomDatePickerFiledState();
}

class _CustomDatePickerFiledState extends State<CustomDatePickerFiled> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pickDate(context).then(
          (value) {
            if (value != null) {
              setState(() {
                widget.controller.text =
                    value.formatDateOnlyWithLocal(context.locale.languageCode);
              });
            }
          },
        );
      },
      child: CustomTextFiled(
        controller: widget.controller,
        enable: false,
        hintText: "DD/MM/YYYY",
        prefixIcon: CustomSvgIcon(
          Assets.icons.dateIcon,
          size: 20.sp,
        ),
      ),
    );
  }

  Future<DateTime?> pickDate(context) async {
    final DateTime? picked = await showDatePicker(
        helpText: "Choose Date",
        context: context,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppMaterialColors.green.shade200,
                onPrimary: context.isDark
                    ? AppMaterialColors.white
                    : AppMaterialColors.black.shade200,
                onSurface: context.isDark
                    ? AppMaterialColors.white
                    : AppMaterialColors.black.shade200,
              ),
            ),
            child: child!,
          );
        },
        initialDate: DateTime.now(),
        firstDate:
            (widget.firstDate != null) ? widget.firstDate! : DateTime(1900, 8),
        lastDate:
            (widget.lastDate != null) ? widget.lastDate! : DateTime.now());

    return picked;
  }
}
