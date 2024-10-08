import 'package:dawaa24/core/presentation/widgets/svg_icon.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/theme/app_material_color.dart';

class DrawerWidget extends StatelessWidget {
  final String backGroundImage;
  final String image;
  final String title;
  final VoidCallback onPreess;
  const DrawerWidget(
      {Key? key,
      required this.backGroundImage,
      required this.image,
      required this.onPreess,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPreess,
      child: Container(
        height: 105.h,
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            image: DecorationImage(
              image: AssetImage(backGroundImage),
              alignment: Alignment.centerLeft,
            ),
            borderRadius: BorderRadius.circular(10.r)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomSvgIcon(
              image,
              color: context.isDark ? AppMaterialColors.white : null,
            ),
            SizedBox(
              height: 4.0.h,
            ),
            Text(title,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ))
          ],
        ),
      ),
    );
  }
}
