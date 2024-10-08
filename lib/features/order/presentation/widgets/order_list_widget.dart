import 'package:dawaa24/core/presentation/resources/theme/app_color.dart';
import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/features/order/data/model/order_list_model.dart';
import 'package:dawaa24/router.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OrderListCardWidget extends StatelessWidget {
  final OrderListModel model;

  const OrderListCardWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Expanded(
                child: Text(
                  model.pharmacyName ?? '',
                  style: context.textTheme.headlineMedium,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: model.total ?? '0',
                      style: context.textTheme.headlineMedium,
                    ),
                    TextSpan(
                      text: ' ${model.currency}',
                      style: context.textTheme.labelSmall!.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 11.sp),
                    ),
                  ],
                ),
              ),
            ]),
            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    "#ID-${model.orderId}",
                    style: context.textTheme.bodyMedium!
                        .copyWith(color: HexColor.fromHex("#76738F")),
                  ),
                ),
                Text(
                  model.createdOn!.toInt().fromMillisecondsSinceEpochGetDate(
                      context.locale.languageCode),
                  style: context.textTheme.bodyMedium!
                      .copyWith(color: HexColor.fromHex("#76738F")),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.5.h),
                  decoration: BoxDecoration(
                      color:
                          model.orderStatus?.getStatusColor().withOpacity(0.15),
                      borderRadius: BorderRadius.circular(24.r)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        color: model.orderStatus?.getStatusColor(),
                        size: 13.sp,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        model.orderStatus?.getName() ?? "",
                        style: context.textTheme.bodyMedium!.copyWith(
                            color: model.orderStatus?.getStatusColor()),
                      ),
                    ],
                  ),
                ),
                Text(
                  model.orderType?.getName() ?? "",
                  style: context.textTheme.bodyMedium!
                      .copyWith(color: HexColor.fromHex("#76738F")),
                ),
              ],
            ),
            SizedBox(
              height: 6.h,
            ),
            const Divider(
              thickness: 1,
              height: 3,
            ),
            SizedBox(
              height: 6.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      context.push(AppPaths.pharmacies.pharmacyDetails,
                          extra: model.pharmacyId!);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: AppMaterialColors.green.shade200,
                          size: 16.sp,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          "my_orders.view_pharmacy".tr(),
                          style: context.textTheme.bodyLarge!.copyWith(
                              color: AppMaterialColors.green.shade200),
                        ),
                      ],
                    )),
                InkWell(
                  onTap: () {
                    context.push(AppPaths.orderPaths.orderDetails,
                        extra: model.id);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: AppColors.mainGradient(angle: 0),
                        borderRadius: BorderRadius.circular(4.r)),
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 7.5.h),
                    child: Text(
                      "my_orders.view_details".tr(),
                      style: context.textTheme.bodyLarge!.copyWith(
                          color: context.theme.colorScheme.background),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
