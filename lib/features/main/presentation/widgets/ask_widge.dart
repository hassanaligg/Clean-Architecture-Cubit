import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/presentation/widgets/svg_icon.dart';
import '../../../../core/utils/extentions.dart';

class AskWidget extends StatelessWidget {
  final double? width;
  final String icon;
  final String title;
  final void Function()? onPressed;

  const AskWidget(
      {super.key,
      required this.icon,
      required this.title,
      this.width,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 110.h,
        width: width ?? 108.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: HexColor.fromHex('#D8DEF5')),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomSvgIcon(
                icon,
                size: 40.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,

                ),
              ),
            ]),
      ),
    );
  }
}
