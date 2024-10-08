import 'package:dawaa24/core/utils/extentions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io' show Platform;

import '../presentation/resources/theme/app_material_color.dart';

class DataPickerService {
  Future<DateTime?> pickDate(
      {required BuildContext context,
      DateTime? initialDate,
      DateTime? firstDate,
      DateTime? lastDate}) async {
    initialDate ??= DateTime.now();
    firstDate ??= DateTime(1900, 1);
    lastDate ??= DateTime(2050, 12);

    initialDate = DateUtils.dateOnly(initialDate);
    firstDate = DateUtils.dateOnly(firstDate);
    lastDate = DateUtils.dateOnly(lastDate);

    if (Platform.isIOS) {
      return showCupertinoDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
      );
    }
    return showMaterialDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
  }

  Future<DateTime?> showCupertinoDatePicker(
      {required BuildContext context,
      required DateTime initialDate,
      required DateTime firstDate,
      required DateTime lastDate}) async {
    DateTime? picked;

    await showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 300,
        color: context.theme.dialogBackgroundColor,
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                          fontSize: 20.sp,
                          color: context.isDark
                              ? AppMaterialColors.white
                              : AppMaterialColors.black.shade200)),
                ),
                child: CupertinoDatePicker(
                    minimumDate: firstDate,
                    initialDateTime: initialDate,
                    maximumDate: lastDate,
                    mode: CupertinoDatePickerMode.date,
                    backgroundColor: context.theme.scaffoldBackgroundColor,
                    onDateTimeChanged: (val) {
                      picked = val;
                    }),
              ),
            ),
            CupertinoButton(
              child: const Text('OK'),
              onPressed: () {
                picked ??= DateTime.now();
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
    return picked;
  }

  Future<DateTime?> showMaterialDatePicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) {
    return showDatePicker(
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
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
  }
}
