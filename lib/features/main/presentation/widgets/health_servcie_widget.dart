import 'package:dawaa24/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/presentation/resources/assets.gen.dart';
import '../../../../core/presentation/resources/theme/app_color.dart';
import '../../../../core/presentation/widgets/svg_icon.dart';

class HealthServiceWidget extends StatelessWidget {
  final String icon;
  final String title;
  final void Function()? onPressed;

  const HealthServiceWidget(
      {super.key, required this.icon, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 115.h,
        width: 114.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(color: HexColor.fromHex('#D8DEF5')),
            color: context.isDark
                ? AppColors.black.shade100
                : AppColors.blue.shade200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSvgIcon(
              Assets.icons.covid19Icon,
              size: 50.h,
              color: context.isDark ? Colors.white : null,
            ),
            SizedBox(
              height: 7.h,
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }
}
