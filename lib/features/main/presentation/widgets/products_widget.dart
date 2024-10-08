import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/presentation/resources/theme/app_material_color.dart';
import '../../../../core/presentation/widgets/product_widget.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        productSection(context, "home_page.popular_items".tr()),
        SizedBox(
          height: 16.h,
        ),
        productSection(context, "home_page.nearest_provider".tr()),
        SizedBox(
          height: 16.h,
        ),
        productSection(context, "home_page.best_seller".tr()),
      ],
    );
  }

  productSection(BuildContext context, String title) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              GestureDetector(
                onTap: () {},
                child: Text("home_page.view_all".tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppMaterialColors.green.shade100)),
              )
            ],
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        SizedBox(
          width: 1.sw,
          height: 200.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              width: 12.w,
            ),
            itemBuilder: (context, index) {
              return const ProductWidget();
            },
          ),
        )
      ],
    );
  }
}
