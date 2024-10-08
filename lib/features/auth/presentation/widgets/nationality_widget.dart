import 'package:dawaa24/core/data/model/nationality_model.dart';
import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showNationalities({
  required BuildContext context,
  required List<NationalityModel> nationalities,
  required Function onItemSelected,
}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
            width: 1.sw,
            height: 0.9.sh,
            decoration: BoxDecoration(
              color: context.isDark
                  ? AppMaterialColors.black.shade50
                  : AppMaterialColors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                // Padding(
                //   padding:
                //       EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //
                //     ],
                //   ),
                // ),
                Expanded(
                  child: ListView.separated(
                    itemCount: nationalities.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0.0),
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      height: 20.h,
                    ),
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          onItemSelected(nationalities[index]);
                          Navigator.pop(context);
                        },
                        title: Text(
                          nationalities[index].name!,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                  color: context.isDark
                                      ? AppMaterialColors.white
                                      : AppMaterialColors.black.shade200),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ));
}
