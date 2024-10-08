import 'dart:async';

import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';
import 'package:dawaa24/core/presentation/widgets/back_button.dart';
import 'package:dawaa24/core/presentation/widgets/loading_banner.dart';
import 'package:dawaa24/core/utils/constants.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../core/presentation/resources/assets.gen.dart';
import '../../../../../core/presentation/resources/theme/app_color.dart';
import '../../../../../core/presentation/resources/theme/app_gradients.dart';
import '../../../../../core/presentation/widgets/custom_container.dart';
import '../../../../../core/presentation/widgets/error_banner.dart';
import '../../../../../core/presentation/widgets/svg_icon.dart';
import '../../cubits/quick_register_cubit/quick_register_cubit.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key, required this.cubit});

  final QuickRegisterCubit cubit;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController otp = TextEditingController();
  Timer? timer;

  int counter = AppConstant.otpTimeInSec;
  late QuickRegisterCubit quickRegisterCubit;
  late GlobalKey<FormState> formKey;

  startTimer() {
    counter = AppConstant.otpTimeInSec;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (counter > 0) {
          counter--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  initState() {
    startTimer();
    quickRegisterCubit = widget.cubit;
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuickRegisterCubit, QuickRegisterState>(
      bloc: quickRegisterCubit,
      listener: (context, state) {
        if (state.status == QuickRegisterStatus.resendOtpSuccess) {
          "otp_page.otp has been sent successfully".tr().showToast();

          quickRegisterCubit.changeStatus(QuickRegisterStatus.success);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              title: Text(
                'failures.otp.back'.tr(),
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(fontSize: 13.sp),
              ),
              centerTitle: false,
              leadingWidth: 40.w,
              titleSpacing: 0.w,
              leading: CustomBackButton(
                  size: 18.sp,
                  color: context.isDark ? AppColors.white : AppColors.black)),
          body: SafeArea(
            child: InkWell(
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              splashColor: Colors.transparent,
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
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
                      Text(
                        "sign_in.sign_in_msg".tr(),
                        style: TextStyle(
                            fontSize: 22.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        "otp_page.otp_send_message".tr(),
                        textAlign: TextAlign.center,
                        style: context.textTheme.titleSmall,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              context.pop();
                            },
                            child: Text(
                              "otp_page.change".tr(),
                              textAlign: TextAlign.center,
                              style: context.textTheme.titleSmall!
                                  .copyWith(color: AppMaterialColors.green[75]),
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              "${state.phoneNumberModel.toString()} . ",
                              textAlign: TextAlign.center,
                              style: context.textTheme.titleSmall!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      Text(
                        "sign_up.enter_your_otp".tr(),
                        textAlign: TextAlign.center,
                        style: context.textTheme.titleSmall,
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 75.w),
                        child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: _pinFieldWidget(context)),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "sign_up.haven_code".tr(),
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          counter > 0
                              ? Text(
                                  counter.formatTimeFromSecondsToMinSec(),
                                  style: TextStyle(
                                      color: AppMaterialColors.green.shade200,
                                      fontSize: 12.sp),
                                )
                              : InkWell(
                                  onTap: () {
                                    quickRegisterCubit.reSendOtp();
                                    startTimer();
                                  },
                                  child: Text(
                                    "otp_page.resend_otp".tr(),
                                    style: TextStyle(
                                      color: AppMaterialColors.green.shade200,
                                      fontSize: 12.sp,
                                    ),
                                  )),
                        ],
                      ),
                      SizedBox(
                        height: 47.h,
                      ),
                      if (state.status == QuickRegisterStatus.verifyOtpError &&
                          state.failure != null)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: ErrorBanner(failure: state.failure!),
                        ),
                      (state.status == QuickRegisterStatus.loading)
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: LoadingBanner(),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              child: CustomContainer(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                borderRadius: 10,
                                gradient: AppGradients.continerGradient,
                                child: TextButton(
                                  child: Text(
                                    "otc_select_address_page.confirm".tr(),
                                    style: TextStyle(
                                        color: AppMaterialColors.white,
                                        fontSize: 14.sp),
                                  ),
                                  onPressed: () async {
                                    if (!(formKey.currentState!.validate())) {
                                      state.enableValidation();
                                    } else {
                                      quickRegisterCubit.submitVerifyOtp();
                                    }
                                  },
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _pinFieldWidget(BuildContext context) {
    return PinCodeTextField(
      validator: (str) => str == null
          ? null
          : str.length < 4
              ? "sign_up.please_enter_otp_first".tr()
              : null,
      autovalidateMode: quickRegisterCubit.state.validateField
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      backgroundColor: Colors.transparent,
      hintCharacter: "",
      hintStyle: Theme.of(context).textTheme.bodyLarge,
      appContext: context,
      textStyle: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(color: AppMaterialColors.black.shade100),
      length: 4,
      animationType: AnimationType.fade,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      cursorColor: Theme.of(context).primaryColor,
      enableActiveFill: true,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(12.r),
        fieldHeight: 42.w,
        fieldWidth: 42.w,
        activeFillColor: AppMaterialColors.grey.shade200,
        inactiveFillColor: AppMaterialColors.grey.shade200,
        selectedFillColor: AppMaterialColors.grey.shade200,
        errorBorderColor: AppMaterialColors.red.shade50,
        borderWidth: 5,
        activeColor: AppMaterialColors.grey.shade200,
        selectedColor: AppMaterialColors.grey.shade200,
        disabledColor: AppMaterialColors.grey.shade200,
        inactiveColor: AppMaterialColors.grey.shade200,
      ),
      errorTextSpace: 30,
      animationDuration: const Duration(milliseconds: 300),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        quickRegisterCubit.onOTPChanged(value);
      },
      beforeTextPaste: (text) {
        print("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
    );
  }
}
