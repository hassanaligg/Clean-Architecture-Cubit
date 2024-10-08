import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';
import 'package:dawaa24/core/presentation/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/presentation/resources/theme/app_color.dart';
import '../../utils/extentions.dart';
import 'network_image.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({
    super.key,
  });

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 157.w,
        height: 200.h,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: HexColor.fromHex('#D8DEF5'),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    topRight: Radius.circular(8.r),
                  ),
                  child: SizedBox(
                    width: 1.sw,
                    height: 100.h,
                    child: const CustomNetworkImage(
                      url: "Image",
                      boxFit: BoxFit.cover,
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Blood Pressure",
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 1,
                          ),
                          Text(
                            "Al Noor Pharmacy",
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: AppColors.green.shade100,
                            ),
                            maxLines: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "1200 ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.sp),
                                    ),
                                    TextSpan(
                                      text: "pharmacies.aed".tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(fontSize: 13.sp),
                                    ),
                                  ],
                                ),
                                maxLines: 1,
                              ),
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.r),
                                    color: AppMaterialColors.blue.shade500),
                                child: const Icon(
                                  Icons.add,
                                  color: AppMaterialColors.white,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
