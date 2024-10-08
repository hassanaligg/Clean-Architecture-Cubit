import 'package:dawaa24/core/presentation/widgets/svg_icon.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../router.dart';
import '../resources/assets.gen.dart';
import '../resources/theme/app_material_color.dart';
import 'custom_container.dart';

class NotAuthWidget extends StatelessWidget {
  const NotAuthWidget({Key? key, required this.content}) : super(key: key);
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
          CustomSvgIcon(
            context.isDark
                ? Assets.images.dawaaDarkLogo
                : Assets.images.dawaaLogo,
            size: 70.h,
          ),
          SizedBox(
            height: 120.h,
          ),
          content,
          SizedBox(
            height: 50.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: CustomContainer(
              width: MediaQuery.of(context).size.width,
              borderRadius: 8.r,
              borderColor: context.isDark
                  ? AppMaterialColors.white
                  : AppMaterialColors.grey.shade400,
              child: TextButton(
                child: Text(
                  "sign_in.login".tr(),
                  style: TextStyle(
                      color: context.isDark
                          ? AppMaterialColors.white
                          : AppMaterialColors.black.shade200,
                      fontSize: 14.sp),
                ),
                onPressed: () {
                  context.push(AppPaths.auth.signIn);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
