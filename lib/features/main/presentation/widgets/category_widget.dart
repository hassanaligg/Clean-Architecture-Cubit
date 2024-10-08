import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/presentation/resources/theme/app_material_color.dart';
import 'category_card.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("home_page.find_items_by_categories".tr(),
                  style: Theme.of(context).textTheme.titleMedium),
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
        SizedBox(height: 16.h,),
        SizedBox(
          width: 1.sw,
          height: 150.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              width: 12.w,
            ),
            itemBuilder: (context, index) {
              return CategoryCard();
            },
          ),
        )
      ],
    );
  }

}
