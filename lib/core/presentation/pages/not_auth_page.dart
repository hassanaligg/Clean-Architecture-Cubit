import 'package:dawaa24/core/domain/params/no_auth_params.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/theme/app_material_color.dart';
import '../widgets/not_auth_widget.dart';
import '../../../../core/presentation/widgets/custom_app_bar.dart';

class NoAuthPage extends StatelessWidget {
  const NoAuthPage({Key? key, required this.noAuthParams}) : super(key: key);
  final NoAuthParams noAuthParams;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: noAuthParams.title),
      body: NotAuthWidget(
        content: Column(
          children: [
            Text(
              noAuthParams.title,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              noAuthParams.body,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 14.sp,
                  color: context.isDark
                      ? AppMaterialColors.white
                      : AppMaterialColors.grey.shade300),
            ),
          ],
        ),
      ),
    );
  }
}
