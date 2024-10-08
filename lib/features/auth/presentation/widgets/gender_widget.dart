import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/presentation/widgets/svg_icon.dart';
import '../../../../core/utils/extentions.dart';

class GenderWidget extends StatelessWidget {
  final bool isSelected;
  final String name;
  final String icon;
  final VoidCallback onPress;

  const GenderWidget(
      {super.key,
      this.isSelected = false,
      required this.name,
      required this.onPress,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onPress,
      child: Column(
        children: [
          Container(
            width: 72.w,
            height: 72.h,
            decoration: BoxDecoration(
                border: Border.all(
                    color: isSelected
                        ? AppMaterialColors.green[150]!
                        : HexColor.fromHex('#D8DEF5'),
                    width: 1),
                borderRadius: BorderRadius.circular(12.r),
                color: HexColor.fromHex('#F9FAFF')),
            child: CustomSvgIcon(
              icon,
              color: isSelected
                  ? AppMaterialColors.green[150]
                  : AppMaterialColors.grey[400],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            name,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: HexColor.fromHex('#77738F'), fontSize: 13.sp),
          )
        ],
      ),
    );
  }
}
