/*
import 'package:dawaa24/core/presentation/fields/otp_field.dart';
import 'package:dawaa24/core/presentation/widgets/svg_icon.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/router.dart';
import 'package:easy_localization/easy_localization.dart' as ez;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../core/presentation/resources/assets.gen.dart';
import '../../../../../core/presentation/resources/theme/app_material_color.dart';
import '../../../../../core/presentation/resources/theme/app_gradients.dart';
import '../../../../../core/presentation/widgets/back_button.dart';
import '../../../../../core/presentation/widgets/custom_app_text.dart';
import '../../../../../core/presentation/widgets/custom_container.dart';
import 'package:go_router/src/misc/extensions.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);
  static String navigationKey = "/otp-page";

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 1.sw,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 47.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 24.w,
                    ),
                    CustomBackButton(),
                  ],
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomSvgIcon(
                  context.isDark
                      ? Assets.images.dawaaDarkLogo
                      : Assets.images.dawaaLogo,
                  size: 70.h,
                ),
                SizedBox(
                  height: 90.h,
                ),
                Text(
                  "otp_page.otp_authentication".tr(),
                  style: context.textTheme.headline1,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  "otp_page.otp_send_message".tr(),
                  textAlign: TextAlign.center,
                  style: context.textTheme.subtitle2,
                ),
                SizedBox(
                  height: 32.h,
                ),
                Text(
                  "otp_page.enter_otp".tr(),
                  textAlign: TextAlign.center,
                  style: context.textTheme.subtitle2,
                ),
                SizedBox(
                  height: 24.h,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80.w),
                    child: _pinFieldWidget(context)),
                SizedBox(
                  height: 24.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText.p14(
                      "otp_page.didn't_receive_the_code".tr(),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    InkWell(
                        onTap: () {},
                        child: CustomText.p14(
                          "otp_page.resend_otp".tr(),
                          color: AppMaterialColors.green.shade200,
                        )),
                  ],
                ),
                SizedBox(
                  height: 200.h,
                ),
                CustomContainer(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  borderRadius: 10,
                  gradient: AppGradients.greenGradient,
                  marginRight: 10,
                  marginLeft: 10,
                  child: TextButton(
                    child: Text(
                      "otp_page.verify_otp".tr(),
                      style: const TextStyle(
                          color: AppMaterialColors.white, fontSize: 14),
                    ),
                    onPressed: () {

                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _pinFieldWidget(BuildContext context) {
    // OtpField field = OtpField.pure();
    TextEditingController controller = TextEditingController();
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        controller: controller,
        backgroundColor: Colors.transparent,
        hintCharacter: "",
        hintStyle: Theme.of(context).textTheme.bodyText1,
        appContext: context,
        textStyle: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(color: AppMaterialColors.black.shade100),
        pastedTextStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
        length: 4,
        animationType: AnimationType.fade,
        // validator: (v) => context.fieldFailureParser(field.validator(v ?? '')),
        cursorColor: Theme.of(context).primaryColor,
        enableActiveFill: true,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(8),

          fieldHeight: 54.w,
          fieldWidth: 54.w,
          activeFillColor: AppMaterialColors.grey.shade200,
          inactiveFillColor: AppMaterialColors.grey.shade200,
          selectedFillColor: AppMaterialColors.grey.shade200,
          errorBorderColor: AppMaterialColors.red.shade50,
          // fieldOuterPadding: EdgeInsets.only(right: 12.w),
          borderWidth: 5,
          activeColor: AppMaterialColors.grey.shade200,
          selectedColor: AppMaterialColors.grey.shade200,
          disabledColor: AppMaterialColors.grey.shade200,
          inactiveColor: AppMaterialColors.grey.shade200,
        ),
        // errorTextSpace: 30,
        animationDuration: const Duration(milliseconds: 300),
        keyboardType: TextInputType.number,
        onChanged: (value) {
          // field = OtpField.dirty(value);
          controller.text = value;
          setState(() {});
        },
      ),
    );
  }
}
*/
