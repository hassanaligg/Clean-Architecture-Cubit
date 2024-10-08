import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';
import 'package:dawaa24/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/resources/assets.gen.dart';
import '../../../../core/presentation/widgets/svg_icon.dart';
import '../../../../core/utils/extentions.dart';

class AddressHomeWidget extends StatelessWidget {
  const AddressHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: InkWell(
        onTap: () {
          context.push(AppPaths.address.addressList);
        },
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: CustomSvgIcon(
                Assets.icons.locationGreenIcon,
                color: context.isDark ? AppMaterialColors.white : null,
              ),
            ),
            Expanded(
              child: Text("Business Point, Silicon, Bur Dubai sdsadasdasddasd",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium),
            ),
            SizedBox(
              width: 30.w,
            ),/*
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: HexColor.fromHex('#D8DEF5'))),
              child: CustomSvgIcon(
                Assets.icons.qrIcon,
                color: context.isDark ? AppMaterialColors.white : null,
              ),
            )*/
          ],
        ),
      ),
    );
  }
}
