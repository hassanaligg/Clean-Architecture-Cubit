import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';
import 'package:dawaa24/core/presentation/widgets/svg_icon.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dawaa24/core/utils/extentions.dart';

import '../resources/assets.gen.dart';
import 'custom_container.dart';

class CustomDialog extends StatelessWidget {
  final String? title, descriptions, text;
  final String? img;
  final VoidCallback? onPress;
  final bool? withButton;
  final bool isActiveCancelButton;

  const CustomDialog(
      {super.key,
      required this.title,
      required this.descriptions,
      required this.text,
      this.withButton = true,
      this.onPress,
      this.img,
      this.isActiveCancelButton = false});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: context.isDark
            ? AppMaterialColors.black.shade200
            : AppMaterialColors.white,
        borderRadius: BorderRadius.circular(21.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (withButton!)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CustomSvgIcon(
                    Assets.icons.cancelIcon,
                    color: context.isDark
                        ? AppMaterialColors.white
                        : AppMaterialColors.black.shade200,
                    size: 16.w,
                  ),
                ),
              ],
            ),
          if (!withButton!)
            Text(
              title!,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontSize: 18.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          if (withButton!) CustomSvgIcon(Assets.icons.homeDialogIcon),
          SizedBox(
            height: 15.h,
          ),
          if (withButton!) Image.asset(Assets.images.dawaaLogoDialog.path),
          SizedBox(
            height: 16.h,
          ),
          Text(
            descriptions!,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40.h,
          ),
          if (!withButton!)
            Directionality(
              textDirection:
                  context.isArabic ? TextDirection.ltr : TextDirection.rtl,
              child: Row(
                children: [
                  if (isActiveCancelButton)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: CustomContainer(
                            height: 40.h,
                            borderRadius: 8.r,
                            backgroundColor: AppMaterialColors.grey.shade300,
                            child: Center(
                              child: Text(
                                "drawer.No".tr(),
                                style: TextStyle(
                                    color: AppMaterialColors.white,
                                    fontSize: 14.sp),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: InkWell(
                        onTap: onPress,
                        child: CustomContainer(
                          height: 40.h,
                          borderRadius: 8.r,
                          backgroundColor: AppMaterialColors.green.shade200,
                          child: Center(
                            child: Text(
                              "drawer.Yes".tr(),
                              style: TextStyle(
                                  color: AppMaterialColors.white,
                                  fontSize: 14.sp),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
