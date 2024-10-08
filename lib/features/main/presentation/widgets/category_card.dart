import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/presentation/resources/theme/app_material_color.dart';
import '../../../../core/presentation/widgets/network_image.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CustomNetworkImage(
                url: "Image",
                height: 90.h,
                width: 162.w,
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            const Text("Category Name"),
            Text(
              "555 items",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppMaterialColors.green.shade100),
            ),
          ],
        ),
        //Text(productCategoryEntity.categoryName??"")
      ),
    );
  }
}
