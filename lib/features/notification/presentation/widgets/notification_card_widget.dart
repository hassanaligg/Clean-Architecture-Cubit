import 'package:dawaa24/core/data/enums/notification_type_enum.dart';
import 'package:dawaa24/core/presentation/resources/assets.gen.dart';
import 'package:dawaa24/core/presentation/resources/theme/app_color.dart';
import 'package:dawaa24/core/presentation/widgets/network_image.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/features/notification/data/model/notification_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationCardWidget extends StatelessWidget {
  final NotificationModel model;

  const NotificationCardWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.white,
          border: Border.all(
              color: (model.isRead ?? false)
                  ? HexColor.fromHex('#D8DEF5')
                  : context.theme.primaryColor),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.shade200,
              spreadRadius: 0,
              blurRadius: 30,
              offset: const Offset(0, 4),
            ),
          ]),
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomNetworkImage(
              url: model.iconThumbnail ?? '',
              errorWidgetIcon: Image.asset(Assets.icons.bell.path,
                  color: context.theme.primaryColor,
                  width: 15.w,
                  fit: BoxFit.contain),
              width: 50.w,
              height: 50.w,
              isBase64: true,
              boxFit: BoxFit.cover,
              borderRadius: BorderRadius.circular(200.r),
            ),
            SizedBox(
              width: 12.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title ?? '',
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: HexColor.fromHex("#334155"),
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    model.content ?? '',
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: HexColor.fromHex("#334155"),
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    (model.createdOn ?? 0)
                        .toInt()
                        .fromMillisecondsSinceEpochGetDateWithHour(
                            context.locale.languageCode),
                    style: TextStyle(
                      fontSize: 9.sp,
                      color: HexColor.fromHex("#334155"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
