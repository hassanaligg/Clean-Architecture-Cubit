import 'dart:ui';

import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';
import 'package:dawaa24/core/presentation/widgets/loading_banner.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/core/utils/parse_helpers/failure_parser.dart';
import 'package:dawaa24/features/auth/presentation/cubits/change_language/change_language_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/resources/assets.gen.dart';
import '../../../../core/presentation/widgets/custom_dialog.dart';
import '../../../../core/presentation/widgets/network_image.dart';
import '../../../../core/presentation/widgets/svg_icon.dart';
import '../../../../di/injection.dart';
import '../../../../router.dart';
import '../../../auth/domain/repository/auth_repository.dart';
import '../../../auth/presentation/cubits/log_out/log_out_cubit.dart';
import '../cubits/main_page_cubit/main_page_cubit.dart';

class MyDrawer extends StatefulWidget {
  final VoidCallback onLanguageChanged;
  final VoidCallback onProfileUpdated;

  const MyDrawer(
      {super.key,
      required this.onLanguageChanged,
      required this.onProfileUpdated});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          top: MediaQuery.of(context).padding.top + 30.h,
          start: 10.w,
          bottom: MediaQuery.of(context).padding.top + 30.h,
        ),
        child: Column(
          children: <Widget>[
            Row(
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
                        "drawer.hey".tr(),
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontSize: 14.sp),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        BlocProvider.of<MainPageCubit>(context)
                                .state
                                .profileModel!
                                .name ??
                            "",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 16.sp),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            drawerWidget(
              icon: Assets.icons.drawerPerson,
              title: "drawer.account".tr(),
              onPress: () async {
                bool? isUpdated =
                    await context.push(AppPaths.auth.editProfilePage) ?? false;
                if (isUpdated) {
                  widget.onProfileUpdated;
                }
              },
            ),
            drawerWidget(
              icon: Assets.icons.drawerSetting,
              title: "drawer.setting".tr(),
              onPress: () {
                "chat.coming_soon"
                    .tr()
                    .showToast(toastGravity: ToastGravity.CENTER);
              },
            ),
            drawerWidget(
              icon: Assets.icons.drawerLanguage,
              title: "drawer.change_language".tr(),
              onPress: () {
                _showLanguageChooser(context);
              },
            ),
            drawerWidget(
              icon: Assets.icons.drawerAbout,
              title: "drawer.about_Dawaa24".tr(),
              onPress: () {
                "chat.coming_soon"
                    .tr()
                    .showToast(toastGravity: ToastGravity.CENTER);
              },
            ),
            drawerWidget(
              icon: Assets.icons.drawerAppTips,
              title: "drawer.app_Tips".tr(),
              onPress: () {
                "chat.coming_soon"
                    .tr()
                    .showToast(toastGravity: ToastGravity.CENTER);
              },
            ),
            drawerWidget(
              icon: Assets.icons.drawerShare,
              title: "drawer.share".tr(),
              onPress: () {
                "chat.coming_soon"
                    .tr()
                    .showToast(toastGravity: ToastGravity.CENTER);
              },
            ),
            BlocProvider(
              create: (context) => LogOutCubit(),
              child: BlocConsumer<LogOutCubit, LogOutState>(
                listener: (context, state) {
                  if (state.status == LogOutStatus.error) {
                    FailureParser.mapFailureToString(
                            failure: state.failure!, context: context)
                        .showToast();
                  }
                  if (state.status == LogOutStatus.success) {
                    // "drawer.Logout successfully".tr().showToast();
                  }
                },
                builder: (context, state) {
                  return drawerWidget(
                      icon: Assets.icons.drawerLogout,
                      title: "drawer.logout".tr(),
                      onPress: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext contextDialog) {
                              return CustomDialog(
                                title: "drawer.Logout".tr(),
                                descriptions: "drawer.confirm_logout".tr(),
                                text: '',
                                onPress: () {
                                  BlocProvider.of<LogOutCubit>(context)
                                      .logOut();
                                },
                                withButton: false,
                                img: null,
                                isActiveCancelButton: true,
                              );
                            });
                      },
                      titleColor: AppMaterialColors.red);
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 20.w, end: 0.25.sw),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomSvgIcon(
                    Assets.icons.drawerX,
                    onPress: () {
                      "chat.coming_soon"
                          .tr()
                          .showToast(toastGravity: ToastGravity.CENTER);
                    },
                  ),
                  CustomSvgIcon(
                    Assets.icons.drawerIntgram,
                    onPress: () {
                      "chat.coming_soon"
                          .tr()
                          .showToast(toastGravity: ToastGravity.CENTER);
                    },
                  ),
                  CustomSvgIcon(
                    Assets.icons.drawerYoutube,
                    onPress: () {
                      "chat.coming_soon"
                          .tr()
                          .showToast(toastGravity: ToastGravity.CENTER);
                    },
                  ),
                  CustomSvgIcon(
                    Assets.icons.drawerFacebook,
                    onPress: () {
                      "chat.coming_soon"
                          .tr()
                          .showToast(toastGravity: ToastGravity.CENTER);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      textAlign: TextAlign.center,
                      "drawer.conditions&privacy".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(fontSize: 16.sp),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Version:1.0.3 Build:28",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontSize: 16.sp, color:AppMaterialColors.grey[300]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageChooser(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => ChangeLanguageCubit(),
          child: BlocConsumer<ChangeLanguageCubit, ChangeLanguageState>(
            listener: (context, state) {
              if (state.status == ChangeLanguageStatus.error) {
                FailureParser.mapFailureToString(
                        failure: state.failure!, context: context)
                    .showToast();
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CupertinoActionSheet(
                      actions: <Widget>[
                        CupertinoActionSheetAction(
                          child: Text(
                            'sign_in.english'.tr(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          onPressed: () async {
                            if (context.isArabic) {
                              bool isDone =
                                  await BlocProvider.of<ChangeLanguageCubit>(
                                          context)
                                      .changeLanguage(isArabic: false);
                              if (isDone) {
                                context.setLocale(const Locale("en"));
                                getIt<AuthRepository>().setLangKey("en");
                                context.pop();
                                widget.onLanguageChanged();
                              }
                            }
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: Text(
                            'sign_in.arabic'.tr(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          onPressed: () async {
                            if (!context.isArabic) {
                              bool isDone =
                                  await BlocProvider.of<ChangeLanguageCubit>(
                                          context)
                                      .changeLanguage(isArabic: true);
                              if (isDone) {
                                context.setLocale(const Locale("ar"));
                                getIt<AuthRepository>().setLangKey("ar");
                                context.pop();
                                widget.onLanguageChanged();
                              }
                            }
                          },
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        child: Text(
                          'address.cancel'.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        onPressed: () {
                          context.pop();
                        },
                      ),
                    ),
                  ),
                  if (state.status == ChangeLanguageStatus.loading)
                    Positioned(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
                        child: Container(
                          color: Colors.black.withOpacity(
                              0.1), // Optional: Adjust opacity to your needs
                        ),
                      ),
                    ),
                  if (state.status == ChangeLanguageStatus.loading)
                    const Center(
                      child: LoadingBanner(),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  drawerWidget({
    required VoidCallback onPress,
    required String title,
    required String icon,
    Color? titleColor,
  }) {
    return Column(
      children: [
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          onTap: onPress,
          child: Row(
            children: [
              Container(
                width: 45.w,
                height: 45.h,
                margin: EdgeInsetsDirectional.only(start: 10.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: HexColor.fromHex('#E2E7FF').withOpacity(0.6)),
                child: Center(
                  child: CustomSvgIcon(icon),
                ),
              ),
              SizedBox(
                width: 15.w,
              ),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: titleColor ?? null),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8.w,
        ),
        Divider(
          color: HexColor.fromHex('#E9EDF7'),
          endIndent: 10.w,
          indent: 10.w,
        ),
      ],
    );
  }
}
