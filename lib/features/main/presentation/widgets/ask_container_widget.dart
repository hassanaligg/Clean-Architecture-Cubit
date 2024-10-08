import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';
import 'package:dawaa24/features/main/presentation/widgets/ask_widge.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/presentation/resources/assets.gen.dart';

class AskContainerWidget extends StatelessWidget {
  const AskContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AskWidget(
                width: 120.w,
                icon: Assets.icons.prescriptionAskIcon,
                title: "home_page.prescription".tr(),
              ),
              AskWidget(
                width: 120.w,
                icon: Assets.icons.productIcon,
                title: "product.products".tr(),
              ),
              AskWidget(
                width: 120.w,
                icon: Assets.icons.refillIcon,
                title: "home_page.refill".tr(),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        Container(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.transparent
              : AppMaterialColors.grey.shade50,
          padding: EdgeInsetsDirectional.only(
              start: 20.w, end: 20.w, top: 10.h, bottom: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AskWidget(
                width: 120.w,
                icon: Assets.icons.askDrIcon,
                title: "home_page.ask_doctor".tr(),
              ),
              AskWidget(
                width: 120.w,
                icon: Assets.icons.askPharmIcon,
                title: "home_page.ask_pharmacy".tr(),
              ),
              AskWidget(
                width: 120.w,
                icon: Assets.icons.symptomsIcon,
                title: "home_page.find_doctor_by_symptoms".tr(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
