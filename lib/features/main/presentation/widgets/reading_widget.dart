import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/features/main/presentation/widgets/reading_item_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/presentation/resources/assets.gen.dart';
import '../../../../core/presentation/resources/theme/app_color.dart';
import '../../../../core/presentation/resources/theme/app_material_color.dart';
import '../../../../core/presentation/widgets/svg_icon.dart';

class ReadingWidget extends StatelessWidget {
  const ReadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppMaterialColors.grey.shade50,
      padding: EdgeInsetsDirectional.only(top: 20.h,bottom: 20.h),
      child: Column(
        children: [
          Container(
            width: 388.w,
            height: 121.h,
            decoration: BoxDecoration(
              color:
              context.isDark ? AppMaterialColors.black.shade50 : Colors.white,
              border: Border.all(color: HexColor.fromHex('#D8DEF5')),
              borderRadius: BorderRadius.circular(
                12.r,
              ),
              // color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomSvgIcon(
                    Assets.icons.readingIcon1,
                    size: 70.h,
                    color: context.isDark ? Colors.white : null,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        color: context.isDark
                            ? Colors.white
                            : AppColors.green.shade200,
                        size: 40.h,
                      ),
                      Text(
                        "home_page.add_new_reading".tr(),
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color:
                          context.isDark ? null : AppColors.green.shade200,
                        ),
                      ),
                    ],
                  ),
                  CustomSvgIcon(
                    Assets.icons.readingIcon3,
                    size: 70.h,
                    color: context.isDark ? Colors.white : Colors.grey.shade900,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("home_page.recent_readings".tr(),
                    style: Theme.of(context).textTheme.titleMedium),
                GestureDetector(
                  onTap: () {},
                  child: Text("home_page.view_all".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: AppMaterialColors.green.shade100)),
                )
              ],
            ),
          ),
          SizedBox(height: 16.h,),
          SizedBox(
            width: 1.sw,
            height: 120.h,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                width: 12.w,
              ),
              itemBuilder: (context, index) {
                return const ReadingItemWidget();
              },
            ),
          )
        ],
      ),
    );
  }

}
