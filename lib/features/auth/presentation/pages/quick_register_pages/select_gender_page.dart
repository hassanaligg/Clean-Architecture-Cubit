import 'package:dawaa24/core/data/enums/auth_state.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/core/utils/handler/auth_handler.dart';
import 'package:dawaa24/di/injection.dart';
import 'package:dawaa24/features/auth/presentation/widgets/gender_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/presentation/resources/assets.gen.dart';
import '../../../../../core/presentation/resources/theme/app_color.dart';
import '../../../../../core/presentation/resources/theme/app_gradients.dart';
import '../../../../../core/presentation/resources/theme/app_material_color.dart';
import '../../../../../core/presentation/services/validation_service.dart';
import '../../../../../core/presentation/widgets/back_button.dart';
import '../../../../../core/presentation/widgets/custom_container.dart';
import '../../../../../core/presentation/widgets/custom_form_field.dart';
import '../../../../../core/presentation/widgets/error_banner.dart';
import '../../../../../core/presentation/widgets/loading_banner.dart';
import '../../cubits/quick_register_cubit/quick_register_cubit.dart';

class SelectGenderPage extends StatefulWidget {
  const SelectGenderPage({
    super.key,
  });

  @override
  State<SelectGenderPage> createState() => _SelectGenderPageState();
}

class _SelectGenderPageState extends State<SelectGenderPage> {
  late QuickRegisterCubit cubit;
  late TextEditingController fullNameController;

  @override
  void initState() {
    cubit = QuickRegisterCubit();
    fullNameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            color: context.isDark ? AppColors.white : AppColors.black,
            onPressed: () {
              getIt<AuthHandler>().changeAuthState(AuthState.unAuthenticated);
            },
          )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
        child: BlocConsumer<QuickRegisterCubit, QuickRegisterState>(
          bloc: cubit,
          listener: (context, state) {},
          builder: (context, state) {
            return Form(
              key: state.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 5.w),
                    child: Text(
                      "failures.otp.full_name".tr(),
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: HexColor.fromHex('#77738F'), fontSize: 13.sp),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomFormField(
                    validator: ValidationService.requiredFullNameFieldValidator,
                    autoValidate: state.validateField,
                    controller: fullNameController,
                    boarderRadius: 12.r,
                    fillColor: HexColor.fromHex('#F9FAFF'),
                    hintText: "failures.otp.enter_your_full_name".tr(),
                    hintStyle: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(
                            color: HexColor.fromHex('#B0AEC9'),
                            fontSize: 13.sp),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: "failures.otp.select_gender".tr(),
                          style: context.textTheme.headlineMedium!
                              .copyWith(fontSize: 15.sp),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      GenderWidget(
                        name: "profile.Male".tr(),
                        icon: Assets.icons.maleIcon,
                        isSelected: state.selectedGender == 0,
                        onPress: () {
                          cubit.onChangeSelectedGender(0);
                        },
                      ),
                      SizedBox(
                        width: 18.w,
                      ),
                      GenderWidget(
                        name: "profile.Female".tr(),
                        icon: Assets.icons.femaleIcon,
                        isSelected: state.selectedGender == 1,
                        onPress: () {
                          cubit.onChangeSelectedGender(1);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 80.h,
                  ),
                  (state.status == QuickRegisterStatus.loading)
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: LoadingBanner(),
                        )
                      : CustomContainer(
                          width: MediaQuery.of(context).size.width,
                          borderRadius: 10,
                          gradient: AppGradients.continerGradient,
                          child: TextButton(
                            child: Text(
                              "failures.otp.get_started".tr(),
                              style: TextStyle(
                                  color: AppMaterialColors.white,
                                  fontSize: 14.sp),
                            ),
                            onPressed: () async {
                              cubit.verifyAccount(fullNameController.text);
                            },
                          ),
                        ),
                  if (state.status == QuickRegisterStatus.error &&
                      state.failure != null)
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 30.h),
                      child: ErrorBanner(failure: state.failure!),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
