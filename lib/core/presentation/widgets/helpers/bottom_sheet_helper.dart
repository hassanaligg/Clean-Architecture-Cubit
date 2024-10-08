import 'dart:io';

import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';
import 'package:dawaa24/core/presentation/widgets/custom_button.dart';
import 'package:dawaa24/core/presentation/widgets/row_info.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/theme/app_gradients.dart';

abstract class BottomSheetHelper {
  static Future showDeliveryFeeBottomSheet({
    required BuildContext context,
    required double subTotal,
    required double deliveryFee,
    required double discountAmount,
    required VoidCallback onPlaceOrder,
  }) async {
    await showModalBottomSheet(
      context: context,
      elevation: 30.0,
      backgroundColor: context.theme.bottomSheetTheme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35.0),
          topRight: Radius.circular(35.0),
        ),
      ),
      builder: (_) {
        return SafeArea(
          child: DraggableScrollableSheet(
            initialChildSize: 0.99,
            builder: (_, controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const SizedBox(
                        width: 130,
                        child: Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          'otc_select_time_page.payment_summary'.tr(),
                          style: context.textTheme.labelMedium,
                        ),
                      ),
                      RowInfoWidget(
                        rowKey: 'otc_select_time_page.sub_total'.tr(),
                        rowValue: subTotal.toStringAsFixed(2),
                        // style: ThemeStyle.blackNormal,
                      ),
                      const SizedBox(height: 10),
                      RowInfoWidget(
                        rowKey: 'otc_select_time_page.delivery_fee'.tr(),
                        rowValue: deliveryFee.toStringAsFixed(2),
                        // style: ThemeStyle.blackNormal,
                      ),
                      const SizedBox(height: 10),
                      RowInfoWidget(
                        rowKey: 'otc_select_time_page.discount_amount'.tr(),
                        rowValue: discountAmount.toString(),
                        // style: ThemeStyle.blackNormal,
                      ),
                      const SizedBox(height: 10),
                      RowInfoWidget(
                        rowKey: 'otc_select_time_page.total_bill'.tr(),
                        rowValue: ((subTotal + deliveryFee) - discountAmount)
                            .toStringAsFixed(2),
                        style: context.textTheme.labelMedium,
                        // style: ThemeStyle.blackSemiBold15,
                      ),
                      SizedBox(height: 40.h),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomButton(
                          width: 388.w,
                          // withGradient: true,
                          color: AppMaterialColors.green[200],
                          onTap: onPlaceOrder,
                          child: Center(
                              child: Text(
                            "otc_select_time_page.place_order".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: Colors.white),
                          )),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  static Future<File?> showPickPhotoBottomSheet(
      {required BuildContext context,
      required String title,
      required Function pickFromCamera,
      required Function pickFromGallery}) async {
    await showModalBottomSheet(
        context: context,
        barrierColor: Colors.black26,
        backgroundColor: Colors.black26,
        elevation: 20,
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: true,
        // gives rounded corner to modal bottom screen
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        builder: (context) => Container(
              height: 285.h,
              width: 1.sw,
              decoration: BoxDecoration(
                color: context.theme.cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 50.w,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Center(
                    child: Text(
                      title,
                      style: context.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      pickFromCamera();
                    },
                    child: Container(
                      width: 308.w,
                      height: 54.h,
                      decoration: BoxDecoration(
                          gradient: AppGradients.greenGradient,
                          borderRadius: BorderRadius.circular(27)),
                      child: Center(
                          child: Text(
                        "rate.Choose_from_camera".tr(),
                        style: context.textTheme.headlineMedium!
                            .copyWith(color: Colors.white),
                      )),
                    ),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  Container(
                      width: 308.w,
                      child: OutlinedButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            pickFromGallery();
                          },
                          child: Center(
                              child: Text(
                            "rate.Choose_from_gallery".tr(),
                          ))))
                ],
              ),
            ));
  }
}
