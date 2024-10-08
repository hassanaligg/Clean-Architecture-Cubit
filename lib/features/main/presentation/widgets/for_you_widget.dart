import 'package:dawaa24/features/main/presentation/widgets/section_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/presentation/resources/assets.gen.dart';
import '../../../../core/presentation/resources/theme/app_color.dart';

class ForYouWidget extends StatelessWidget {
  const ForYouWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: Text(
        "home_page.for_you".tr(),
        style: Theme.of(context).textTheme.titleMedium,
      ),
      child: SizedBox(
        height: 90.h,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                width: 0.59.sw,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.grey.shade50,
                ),
                child: Row(children: [
                  Container(
                    width: 94.w,
                    height: 84,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage(Assets.temp.img.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 11.w,
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Covid 19 - Helping kids cope with stress",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w500, color: Colors.black),
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Text(
                        "home_page.read_more".tr(),
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.green.shade100,
                        ),
                      ),
                    ],
                  )),
                  SizedBox(
                    width: 16.w,
                  ),
                ]),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 20.w,
              );
            },
            itemCount: 3),
      ),
    );
  }
}
