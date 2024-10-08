import 'package:dawaa24/core/utils/extentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'loading_banner.dart';

class LoadingPanel extends StatelessWidget {
  const LoadingPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const LoadingBanner(
              size: 100,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Loading".tr(),
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color:context.isDark?const Color(0xFFECF1FA): const Color(0xFF13344C)),
            ),
          ],
        ),
      ),
    );
  }
}
