import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/presentation/resources/theme/app_material_color.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 1.sw,
      color: Colors.white,
      child: Center(
        child: Text(
          "chat.coming_soon".tr(),
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: AppMaterialColors.green.shade200),
        ),
      ),
    );
  }
}
