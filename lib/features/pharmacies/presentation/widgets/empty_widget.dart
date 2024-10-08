import 'package:dawaa24/core/utils/extentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/presentation/resources/assets.gen.dart';
import '../../../../core/presentation/widgets/svg_icon.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width / 1.9,
                height: MediaQuery.of(context).size.height / 3,
                child: CustomSvgIcon(
                  Assets.images.noResultSearch,
                  size: 0.80.sw,
                  fit: BoxFit.contain,
                )),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "chat.no_result".tr(),
              style: context.textTheme.headlineMedium!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 70.h,
            ),
          ],
        )
      ],
    );
  }
}
