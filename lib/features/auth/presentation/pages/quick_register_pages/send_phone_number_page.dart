import 'package:dawaa24/core/presentation/resources/assets.gen.dart';
import 'package:dawaa24/core/presentation/resources/theme/app_gradients.dart';
import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';
import 'package:dawaa24/core/presentation/widgets/custom_container.dart';
import 'package:dawaa24/core/presentation/widgets/custom_form_field.dart';
import 'package:dawaa24/core/presentation/widgets/error_banner.dart';
import 'package:dawaa24/core/presentation/widgets/loading_banner.dart';
import 'package:dawaa24/core/presentation/widgets/svg_icon.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;

import '../../../../../core/presentation/services/validation_service.dart';
import '../../../../../core/presentation/widgets/custome_phone_number.dart';
import '../../../../../di/injection.dart';
import '../../../domain/repository/auth_repository.dart';
import '../../cubits/quick_register_cubit/quick_register_cubit.dart';

class SendPhoneNumberPage extends StatefulWidget {
  const SendPhoneNumberPage({super.key});

  @override
  State<SendPhoneNumberPage> createState() => _SendPhoneNumberPageState();
}

class _SendPhoneNumberPageState extends State<SendPhoneNumberPage> {
  bool _switchLanguage = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuickRegisterCubit>(
      create: (context) => QuickRegisterCubit(),
      child: BlocListener<QuickRegisterCubit, QuickRegisterState>(
        listener: (context, state) {
          if (state.status == QuickRegisterStatus.sendOtpSuccess) {
            context.push(
              AppPaths.auth.otpPage,
              extra: BlocProvider.of<QuickRegisterCubit>(context),
            );
            BlocProvider.of<QuickRegisterCubit>(context)
                .changeStatus(QuickRegisterStatus.success);
          }
        },
        child: BlocBuilder<QuickRegisterCubit, QuickRegisterState>(
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                // title: Text(
                //   'failures.otp.back'.tr(),
                //   style: Theme.of(context)
                //       .textTheme
                //       .labelMedium!
                //       .copyWith(fontSize: 13.sp),
                // ),
                centerTitle: false,
                leadingWidth: 40.w,
                titleSpacing: 0.w,
                // leading: Padding(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 10.w,
                //   ),
                //   child: CustomBackButton(
                //       size: 18.sp,
                //       color:
                //           context.isDark ? AppColors.white : AppColors.black),
                // ),
              ),
              body: state.status == QuickRegisterStatus.getCountriesLoading
                  ? const LoadingBanner()
                  : SafeArea(
                      child: InkWell(
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        splashColor: Colors.transparent,
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        child: Form(
                          key: state.formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomSvgIcon(
                                  context.isDark
                                      ? Assets.images.dawaaDarkLogo
                                      : Assets.images.dawaaLogo,
                                  size: 70.h,
                                ),
                                SizedBox(
                                  height: 50.h,
                                ),
                                Center(
                                  child: Text(
                                    "sign_in.sign_in_msg".tr(),
                                    style: TextStyle(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Center(
                                  child: Text(
                                    "sign_in.better_tomorrow".tr(),
                                    style: TextStyle(
                                      color: context.isDark
                                          ? AppMaterialColors.white
                                          : AppMaterialColors.black[25],
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 60.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsetsDirectional.only(start: 30.w),
                                  child: Text(
                                    "sign_up.phone_number".tr(),
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppMaterialColors.grey.shade400),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 32.w),
                                  child: Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: CustomFormField(
                                      onChange:
                                          BlocProvider.of<QuickRegisterCubit>(
                                                  context)
                                              .onChangeNumber,
                                      hintText: "(xx) xxx-xxxx".tr(),
                                      validator: ValidationService
                                          .phoneNumberFieldValidator,
                                      autoValidate: state.validateField,
                                      prefixIconWidth: 140.w,
                                      prefixIcon: Row(
                                        children: [
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Expanded(
                                            child: CustomPhoneNumberWidget(
                                              withBorder: false,
                                              withFlag: true,
                                              countries: state.countries ?? [],
                                              withPhoneNumber: false,
                                              validateField:
                                                  state.validateField,
                                              onChange: (phoneNumberModel) {
                                                BlocProvider.of<
                                                            QuickRegisterCubit>(
                                                        context)
                                                    .onPhoneCodeChanged(
                                                        phoneNumberModel);
                                              },
                                              phoneNumberModel:
                                                  state.phoneNumberModel!,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      fillColor: (context.isDark)
                                          ? AppMaterialColors.black[100]
                                          : AppMaterialColors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsetsDirectional.only(start: 30.w),
                                  child: Text(
                                    "sign_up.You_will_receive_verification"
                                        .tr(),
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppMaterialColors.grey.shade400),
                                  ),
                                ),
                                // Spacer(),
                                SizedBox(
                                  height: 72.h,
                                ),
                                if (state.status.name ==
                                        QuickRegisterStatus.error.name &&
                                    state.failure != null)
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30.w),
                                    child: ErrorBanner(failure: state.failure!),
                                  ),
                                (state.status == QuickRegisterStatus.loading)
                                    ? const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: LoadingBanner(),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom,
                                            right: 30.w,
                                            left: 30.w),
                                        child: Column(
                                          children: [
                                            CustomContainer(
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              borderRadius: 10,
                                              gradient:
                                                  AppGradients.continerGradient,
                                              child: TextButton(
                                                child: Text(
                                                  "sign_up.request_otp".tr(),
                                                  style: TextStyle(
                                                      color: AppMaterialColors
                                                          .white,
                                                      fontSize: 14.sp),
                                                ),
                                                onPressed: () async {
                                                  /* await BlocProvider.of<QuickRegisterCubit>(
                                              context)
                                          .toOtpPage();*/
                                                  BlocProvider.of<
                                                              QuickRegisterCubit>(
                                                          context)
                                                      .submit();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
              bottomNavigationBar: state.status ==
                      QuickRegisterStatus.getCountriesLoading
                  ? const SizedBox()
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () => _showLanguageChooser(context),
                          child: Center(
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_drop_down,
                                    size: 20.sp,
                                    color: HexColor.fromHex('#C1C7D0'),
                                  ),
                                  SizedBox(
                                      width: 25.w,
                                      height: 25.w,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100.r),
                                        child: CustomSvgIcon(context.isArabic
                                            ? Assets.icons.uaeFlagCricel
                                            : Assets.icons.englishFlagCircle),
                                      )),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    context.isArabic
                                        ? "sign_in.arabic".tr()
                                        : "sign_in.english".tr(),
                                    style: TextStyle(
                                      // color: AppMaterialColors.black,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 12.h,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text(
                        //       "sign_in.english".tr(),
                        //       style: TextStyle(
                        //           // color: AppMaterialColors.black,
                        //           fontSize: 18.sp,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //     SizedBox(
                        //       height: 25,
                        //       width: 64,
                        //       child: FittedBox(
                        //         fit: BoxFit.contain,
                        //         child: CupertinoSwitch(
                        //           value: context.isArabic ? true : false,
                        //           onChanged: (value) {
                        //             setState(() {
                        //               _switchLanguage = value;
                        //             });
                        //             context.setLocale(Locale(context
                        //                     .locale.languageCode
                        //                     .contains('en')
                        //                 ? 'ar'
                        //                 : 'en'));
                        //           },
                        //           trackColor: AppMaterialColors.green.shade100,
                        //           activeColor: AppMaterialColors.green.shade100,
                        //         ),
                        //       ),
                        //     ),
                        //     Text(
                        //       "sign_in.arabic".tr(),
                        //       style: TextStyle(
                        //           // color: AppMaterialColors.black,
                        //           fontSize: 18.sp,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: MediaQuery.of(context).padding.bottom,
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }

  void _showLanguageChooser(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text(
                'sign_in.english'.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onPressed: () {
                if (context.isArabic) {
                  context.setLocale(const Locale("en"));
                  getIt<AuthRepository>().setLangKey("en");
                  context.pop();
                }
              },
            ),
            CupertinoActionSheetAction(
              child: Text(
                'sign_in.arabic'.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onPressed: () {
                if (!context.isArabic) {
                  context.setLocale(const Locale("ar"));
                  getIt<AuthRepository>().setLangKey("ar");
                  context.pop();
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
        );
      },
    );
  }
}
