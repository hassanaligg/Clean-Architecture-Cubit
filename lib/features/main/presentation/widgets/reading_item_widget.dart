import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/presentation/resources/theme/app_color.dart';
import '../../../../core/presentation/widgets/network_image.dart';

class ReadingItemWidget extends StatelessWidget {
  const ReadingItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: HexColor.fromHex('#D8DEF5')),
            color: context.isDark
                ? AppMaterialColors.black.shade50
                : AppMaterialColors.white),
        padding: const EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "200",
                      style: TextStyle(
                        color: context.isDark
                            ? AppMaterialColors.white
                            : AppColors.green.shade200,
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      "mmHg",
                      style: TextStyle(
                        color: context.isDark
                            ? AppMaterialColors.white
                            : AppColors.grey.shade100,
                        fontSize: 8.sp,
                      ),
                    ),
                    Text(
                      "Blood Pressure",
                      style: TextStyle(
                        color: context.isDark
                            ? AppMaterialColors.white
                            : AppColors.black.shade100,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                    Text(
                      "Normal",
                      style: TextStyle(
                        color: AppColors.green.shade300,
                        fontWeight: FontWeight.bold,
                        fontSize: 8.sp,
                      ),
                    ),
                    Text(
                      DateTime.now().normalFormat(),
                      style: TextStyle(
                        color: context.isDark
                            ? AppMaterialColors.white
                            : AppColors.grey.shade100,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: CustomNetworkImage(
                        url: "Image",
                        height: 30.h,
                        width: 30.h,
                      ),
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
