import 'package:dawaa24/core/presentation/resources/assets.gen.dart';
import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';
import 'package:dawaa24/features/address/data/model/address_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AddressListWidget extends StatelessWidget {
  final Function onTap;
  final Function onDelete;
  final Function onUpdate;
  final AddressModel addressModel;
  final List<String> addressName = [
    'address.home'.tr(),
    'address.work'.tr(),
    'address.office'.tr(),
    'address.other'.tr()
  ];

  AddressListWidget(
      {super.key,
      required this.onTap,
      required this.onDelete,
      required this.addressModel,
      required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding:
            EdgeInsetsDirectional.only(start: 10.w, top: 24.h, bottom: 24.h),
        child: Row(
          children: [
            SvgPicture.asset(Assets.icons.locationIcon),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                            color: AppMaterialColors.green.shade200,
                            borderRadius: BorderRadius.circular(24.r)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(Assets.icons.addressHomeIcon),
                            SizedBox(width: 5.w),
                            Text(
                              addressModel.type == 0
                                  ? addressName[0]
                                  : addressName[1],
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      fontSize: 11.sp, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              addressModel.name!,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          SizedBox(width: 13.w),
                          addressModel.isDefault!
                              ? Icon(
                                  Icons.check_circle_rounded,
                                  color: AppMaterialColors.green.shade200,
                                )
                              : Container(),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${addressModel.buildingName!},${addressModel.apartmentNumber}\n${addressModel.landmark}",
                              style: Theme.of(context).textTheme.bodyMedium,
                              softWrap: true,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    onUpdate();
                  },
                  child: Container(
                      width: 34.h,
                      height: 34.h,
                      padding: EdgeInsets.all(10.h),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xffF2F6F7)),
                      child: SvgPicture.asset(Assets.icons.pen)),
                ),
                SizedBox(height: 8.h),
                InkWell(
                  onTap: () {
                    onDelete();
                  },
                  child: Container(
                      width: 34.h,
                      height: 34.h,
                      padding: EdgeInsets.all(10.h),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xffF2F6F7)),
                      child: SvgPicture.asset(Assets.icons.trash)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
