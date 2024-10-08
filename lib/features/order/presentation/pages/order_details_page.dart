import 'package:dawaa24/core/data/enums/order_list_type_enum.dart';
import 'package:dawaa24/core/data/enums/product_type_enum.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/features/order/data/model/order_details_model.dart';
import 'package:dawaa24/features/order/presentation/cubits/order_details_cubits/order_details_cubit.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/data/enums/order_list_status_enum.dart';
import '../../../../core/presentation/resources/assets.gen.dart';
import '../../../../core/presentation/resources/theme/app_color.dart';
import '../../../../core/presentation/resources/theme/app_material_color.dart';
import '../../../../core/presentation/widgets/back_button.dart';
import '../../../../core/presentation/widgets/custom_pop_up.dart';
import '../../../../core/presentation/widgets/error_panel.dart';
import '../../../../core/presentation/widgets/loading_panel.dart';
import '../../../../core/presentation/widgets/network_image.dart';
import '../../../../core/presentation/widgets/svg_icon.dart';
import '../../../../core/services/launch_service.dart';
import '../../../../router.dart';

class OrderDetailsPage extends StatefulWidget {
  final String orderId;

  const OrderDetailsPage({super.key, required this.orderId});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetailsPage> {
  late final OrderDetailsCubit orderDetailsCubit;

  @override
  void initState() {
    orderDetailsCubit = OrderDetailsCubit();
    orderDetailsCubit.getOrderDetails(widget.orderId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "order.order_details".tr(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: CustomBackButton(
              color: context.isDark ? AppColors.white : AppColors.black),
        ),
        body: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
          bloc: orderDetailsCubit,
          builder: (context, state) {
            return state.status == OrderDetailsStatus.loading
                ? const LoadingPanel()
                : state.status == OrderDetailsStatus.error
                    ? ErrorPanel(
                        failure: state.failure!,
                        onTryAgain: () {
                          orderDetailsCubit.getOrderDetails(widget.orderId);
                        },
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 20.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              orderDetailsTitleWidget(state.orderDetails!),
                              SizedBox(
                                height: 16.h,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        context.push(
                                            AppPaths.pharmacies.pharmacyDetails,
                                            extra: state
                                                .orderDetails!.pharmacyId!);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0.r),
                                          side: BorderSide(
                                            color: AppColors.green.shade200,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'order.view_pharmacy_profile'.tr(),
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: AppColors.green.shade200),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              orderInfo(state.orderDetails!),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                "order.products".tr(),
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              productsWidget(state.orderDetails!)
                            ],
                          ),
                        ),
                      );
          },
        ));
  }

  orderDetailsTitleWidget(OrderDetailsModel order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          order.pharmacyName ?? "",
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 8.h,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 0.5.sw,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomSvgIcon(
                        Assets.icons.orderLocationIcon,
                        size: 12.sp,
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Expanded(
                        child: Text(
                          order.pharmacyAddress ?? "",
                          style: TextStyle(
                              fontSize: 11.sp, color: AppColors.grey[100]),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    LunchUrlService().launchMap(
                      order.pharmacyLatitude!,
                      order.pharmacyLongitude!,
                      withDestination: true,
                    );
                  },
                  child: Text(
                    "order.pharmacy_location".tr(),
                    style: TextStyle(
                        fontSize: 11.sp,
                        decoration: TextDecoration.underline,
                        color: AppColors.green.shade200,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    "#ID-${order.orderId}",
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.grey[100],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: order.orderStatus
                          ?.getStatusColor()
                          .withOpacity(0.15)),
                  child: Row(
                    children: [
                      CustomSvgIcon(
                        Assets.icons.orderTimeIcon,
                        size: 12.sp,
                        color: order.orderStatus?.getStatusColor(),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        order.orderStatus?.getName() ?? "",
                        style: TextStyle(
                            fontSize: 11.sp,
                            color: order.orderStatus?.getStatusColor()),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        const Divider(),
        if (order.orderStatus!.index == 4 || order.orderStatus!.index == 5)
          Stack(
            children: [
              Positioned.fill(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: HexColor.fromHex('#FFFBFB'),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
              Container(
                decoration: DottedDecoration(
                  shape: Shape.box,
                  borderRadius: BorderRadius.circular(8.r),
                  color: HexColor.fromHex('#D8DEF5'),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.orderStatus == OrderListStatusEnum.returned ? "order.returned_reason".tr() : "order.cancel_reason".tr(),
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.green.shade200),
                      ),
                      SizedBox(
                        height: 7.5.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              order.reason ?? "",
                              style: TextStyle(
                                fontSize: 11.sp,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
      ],
    );
  }

  orderInfo(OrderDetailsModel order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "order.order_type".tr(),
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: order.orderType!.getStatusColor(),
              ),
              child: Center(
                child: Text(
                  order.orderType?.getName() ?? "",
                  style: TextStyle(
                    fontSize: 11.sp,
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "order.delivery_date".tr(),
              style: TextStyle(fontSize: 13.sp),
            ),
            Text(
              order.deliveryDate!
                  .toInt()
                  .fromMillisecondsSinceEpochGetDateWithHour(
                      context.locale.languageCode),
              style: TextStyle(fontSize: 11.sp, color: AppColors.grey[100]),
            )
          ],
        ),
        const Divider(),
        SizedBox(
          height: 8.h,
        ),
        if ((order.orderType ?? OrderLisTypeEnum.unKnown) ==
            OrderLisTypeEnum.delivery)
          Text(
            "order.delivery_location".tr(),
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
          ),
        if ((order.orderType ?? OrderLisTypeEnum.unKnown) ==
            OrderLisTypeEnum.delivery)
          SizedBox(
            height: 6.h,
          ),
        if ((order.orderType ?? OrderLisTypeEnum.unKnown) ==
            OrderLisTypeEnum.delivery)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 0.5.sw,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomSvgIcon(
                      Assets.icons.orderLocationIcon,
                      size: 12.sp,
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Expanded(
                      child: Text(
                        order.patientAddressDto!.name!,
                        style: TextStyle(
                            fontSize: 11.sp, color: AppColors.grey[100]),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  LunchUrlService().launchMap(
                    order.patientAddressDto!.latitude!,
                    order.patientAddressDto!.longitude!,
                  );
                },
                child: Text(
                  "order.delivery_location".tr(),
                  style: TextStyle(
                      fontSize: 11.sp,
                      decoration: TextDecoration.underline,
                      color: AppColors.green.shade200,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        if ((order.orderType ?? OrderLisTypeEnum.unKnown) ==
            OrderLisTypeEnum.delivery)
          SizedBox(
            height: 16.h,
          ),
        DottedBorder(
          color: HexColor.fromHex('#D8DEF5'),
          strokeWidth: 1,
          radius: Radius.circular(8.r),
          borderType: BorderType.RRect,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "order.payment".tr(),
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 7.5.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order.paymentMethod!.getName(),
                    style: TextStyle(
                      fontSize: 11.sp,
                    ),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  CustomSvgIcon(
                    order.paymentMethod!.index == 0
                        ? Assets.icons.cashIcon
                        : Assets.icons.visaIcon,
                  ),
                ],
              )
            ],
          ),
        ),
        if ((order.note ?? '').isNotEmpty)
          SizedBox(
            height: 16.h,
          ),
        if ((order.note ?? '').isNotEmpty)
          DottedBorder(
            color: HexColor.fromHex('#D8DEF5'),
            strokeWidth: 1,
            radius: Radius.circular(8.r),
            borderType: BorderType.RRect,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "order.instructions".tr(),
                  style: TextStyle(
                      fontSize: 13.sp, color: AppColors.green.shade200),
                ),
                SizedBox(
                  height: 7.5.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        order.note ?? "",
                        style: TextStyle(
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        SizedBox(
          height: 16.h,
        ),
        Text(
          "order.summery".tr(),
          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 6.h,
        ),
        if (order.orderType != OrderLisTypeEnum.pickUp) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "order.delivery_cost".tr(),
                style: TextStyle(fontSize: 11.sp),
              ),
              (order.deliveryCost == "0.00")
                  ? Text(
                      "order.free".tr(),
                      style: TextStyle(
                          fontSize: 11.sp,
                          color: AppMaterialColors.grey[450],
                          fontWeight: FontWeight.bold),
                    )
                  : Text(
                      "${order.deliveryCost ?? '0'} AED",
                      style: TextStyle(
                          fontSize: 11.sp,
                          color: AppMaterialColors.grey[450],
                          fontWeight: FontWeight.bold),
                    ),
            ],
          ),
        ],
        SizedBox(
          height: 11.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "order.total_cost".tr(),
              style: TextStyle(fontSize: 11.sp),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${order.total} ",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 15.sp),
                  ),
                  TextSpan(
                    text: "pharmacies.aed".tr(),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 12.sp),
                  ),
                ],
              ),
              maxLines: 1,
            ),
          ],
        ),
        const Divider()
      ],
    );
  }

  productsWidget(OrderDetailsModel order) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return productWidget(order.items![index]);
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 10.h,
          );
        },
        itemCount: order.items!.length);
  }

  Widget productWidget(ProductModel product) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: HexColor.fromHex('#D8DEF5')),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 75.w,
            height: 75.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CustomNetworkImage(
                url: product.image ?? "",
                boxFit: BoxFit.contain,
                borderRadius: BorderRadius.zero,
                isBase64: true,
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  product.name ?? "",
                  maxLines: null, // Allows text to wrap to multiple lines
                  style: TextStyle(fontSize: 15.sp),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  "${"order.qty".tr()}: ${product.quantity}",
                  style: TextStyle(fontSize: 15.sp),
                ),
                SizedBox(
                  height: 4.h,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${product.price} ",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 16.sp),
                      ),
                      TextSpan(
                        text: "pharmacies.aed".tr(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontSize: 13.sp),
                      ),
                    ],
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          ),
          Column(
            children: [
              CustomSvgIcon(
                Assets.icons.infoIcon,
                onPress: () {
                  _showPopup(product);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  void _showPopup(ProductModel productModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomPopup(
          title: "",
          boarderRadius: 8.r,
          padding: 10.w,
          customContent: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomSvgIcon(
                        Assets.icons.cancelIcon,
                        color: AppColors.grey[150],
                        size: 14.sp,
                        onPress: () {
                          context.pop();
                        },
                      ),
                    ],
                  ),
                  if (productModel.type == ProductTypeEnum.drug)
                    Text(
                      "order.prescription".tr(),
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                  if (productModel.type == ProductTypeEnum.drug)
                    SizedBox(
                      height: 5.h,
                    ),
                  if (productModel.type == ProductTypeEnum.drug)
                    Text(
                      !(productModel.isOtc!)
                          ? " ${"order.yes".tr()} "
                          : " ${"order.no".tr()}",
                      style: TextStyle(
                          fontSize: 11.sp, color: AppColors.grey[450]),
                    ),
                  if (productModel.type == ProductTypeEnum.drug)
                    SizedBox(
                      height: 10.h,
                    ),
                  if (productModel.type == ProductTypeEnum.product)
                    Text(
                      "order.category".tr(),
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                  if (productModel.type == ProductTypeEnum.product)
                    SizedBox(
                      height: 10.h,
                    ),
                  if (productModel.type == ProductTypeEnum.product)
                    Text(
                      "• ${productModel.categoryName}",
                      style: TextStyle(
                          fontSize: 11.sp, color: AppColors.grey[450]),
                    ),
                  SizedBox(
                    height: 15.h,
                  ),
                  if (productModel.instruction != null)
                    Text(
                      "order.instructions".tr(),
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                  if (productModel.instruction != null)
                    SizedBox(
                      height: 10.h,
                    ),
                  if (productModel.instruction != null)
                    Html(
                      data: productModel.instruction ?? '',
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
