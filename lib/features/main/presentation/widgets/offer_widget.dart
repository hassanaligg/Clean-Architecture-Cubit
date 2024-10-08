import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/presentation/resources/assets.gen.dart';
import '../../../../core/presentation/resources/theme/app_gradients.dart';

class OfferWidget extends StatelessWidget {
  const OfferWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 288.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        gradient: AppGradients.continerGradient,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Special Offer",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: AppMaterialColors.white),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "Upto 50% Off",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppMaterialColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.sp),
                  ),
                  Text(
                    "On selected products\nuntil stock last",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppMaterialColors.white,
                        fontSize: 12.sp,
                        overflow: TextOverflow.ellipsis),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                    ),
                    child: Center(
                      child: Text(
                        "Get Offer Now",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppMaterialColors.white,
                            fontSize: 11.sp,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Image.asset(
              Assets.images.offerImage.path,
              height: 100.h,
              width: 100.h,
            )
          ],
        ),
      ),
    );
  }
}
