import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/features/main/presentation/cubits/main_page_cubit/main_page_cubit.dart';
import 'package:dawaa24/router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/resources/assets.gen.dart';
import '../../../../core/presentation/widgets/network_image.dart';
import '../../../../core/presentation/widgets/svg_icon.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<NewHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).padding.top + 30.h,
              horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              profileWidget(),
              SizedBox(
                height: 35.h,
              ),
              Wrap(
                spacing: 10.w,
                runSpacing: 20.h,
                children: [
                  bodyItem(
                    onPress: () {
                      context.push(AppPaths.pharmacies.scanQrPharmacy);
                    },
                    title: 'home_page.add_pharmacy'.tr(),
                    icon: CustomSvgIcon(
                      Assets.icons.readingIcon2,
                      size: 30.sp,
                    ),
                  ),
                  bodyItem(
                    onPress: () {
                      context.push(AppPaths.pharmacies.pharmacies);
                    },
                    title: 'my_pharmacies.myPharmacies'.tr(),
                    icon: CustomSvgIcon(
                      Assets.icons.myPharmacyIcon,
                      color: AppMaterialColors.green.shade200,
                    ),
                  ),
                  bodyItem(
                    onPress: () {
                      context.push(AppPaths.orderPaths.orderMainPage);
                    },
                    title: 'my_orders.title'.tr(),
                    icon: CustomSvgIcon(
                      Assets.icons.orderPackage,
                      color: AppMaterialColors.green.shade200,
                      size: 30.sp,
                    ),
                  ),
                  bodyItem(
                    width: 1.sw,
                    onPress: () async {
                      bool isUpdated =
                          await context.push(AppPaths.address.addressList) ??
                              false;
                      if (isUpdated) {
                        BlocProvider.of<MainPageCubit>(context).getUserInfo();
                      }
                    },
                    title: 'home_page.my_address'.tr(),
                    icon: CustomSvgIcon(
                      Assets.icons.addressIcon,
                      color: AppMaterialColors.green.shade200,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget profileWidget() {
    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () async {
        bool? isUpdated =
            await context.push(AppPaths.auth.editProfilePage) ?? false;
        if (isUpdated) {
          BlocProvider.of<MainPageCubit>(context).getUserInfo();
        }
      },
      child: Container(
        width: 1.sw,
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.white, // Set the background color if needed
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Shadow color
              spreadRadius: 3, // Spread radius
              blurRadius: 4, // Blur radius
              offset: const Offset(0, 3), // Offset in x and y directions
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.r),
              child: Container(
                width: 70.w,
                height: 70.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: CustomNetworkImage(
                    url: BlocProvider.of<MainPageCubit>(context)
                        .state
                        .profileModel!
                        .profilePhoto,
                    isLoad: false,
                    boxFit: BoxFit.cover,
                    // borderRadius: BorderRadius.circular(50.r),
                    backgroundColor: HexColor.fromHex('#EFF3F5'),
                    errorPadding: 1,
                    isBase64: true,
                    errorWidgetIcon: ClipRRect(
                      borderRadius: BorderRadius.circular(50.r),
                      child: Image.asset(
                        Assets.images.pharamacyBackgroundDef.path,
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    BlocProvider.of<MainPageCubit>(context)
                            .state
                            .profileModel!
                            .name ??
                        "",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.h),
                  if (BlocProvider.of<MainPageCubit>(context)
                      .state
                      .profileModel!
                      .addressName!
                      .isNotEmpty)
                    Text(
                      "${"address.address_name".tr()} : ${BlocProvider.of<MainPageCubit>(context).state.profileModel!.addressName ?? ""}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bodyItem(
      {required VoidCallback onPress,
      required String title,
      double? width,
      required Widget icon}) {
    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onPress,
      child: Container(
        width: width ?? 120.w,
        height: 120.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.white, // Set the background color if needed
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Shadow color
              spreadRadius: 3, // Spread radius
              blurRadius: 4, // Blur radius
              offset: const Offset(0, 3), // Offset in x and y directions
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              SizedBox(
                height: 8.h,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 12.sp, color: AppMaterialColors.green.shade200),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
