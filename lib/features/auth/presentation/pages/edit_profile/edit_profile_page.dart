import 'dart:ui';

import 'package:dawaa24/core/presentation/widgets/back_button.dart';
import 'package:dawaa24/core/presentation/widgets/error_banner.dart';
import 'package:dawaa24/core/presentation/widgets/loading_banner.dart';
import 'package:dawaa24/core/presentation/widgets/loading_panel.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/features/auth/presentation/cubits/change_language/change_language_cubit.dart';
import 'package:dawaa24/features/auth/presentation/cubits/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/presentation/resources/assets.gen.dart';
import '../../../../../core/presentation/resources/theme/app_color.dart';
import '../../../../../core/presentation/resources/theme/app_gradients.dart';
import '../../../../../core/presentation/resources/theme/app_material_color.dart';
import '../../../../../core/presentation/services/image_file_picker_service.dart';
import '../../../../../core/presentation/services/validation_service.dart';
import '../../../../../core/presentation/widgets/custom_container.dart';
import '../../../../../core/presentation/widgets/custom_form_field.dart';
import '../../../../../core/presentation/widgets/custome_phone_number.dart';
import '../../../../../core/presentation/widgets/helpers/bottom_sheet_helper.dart';
import '../../../../../core/presentation/widgets/network_image.dart';
import '../../../../../core/presentation/widgets/svg_icon.dart';
import '../../../../../core/utils/parse_helpers/failure_parser.dart';
import '../../../../../di/injection.dart';
import '../../../../main/presentation/cubits/main_page_cubit/main_page_cubit.dart';
import '../../../domain/repository/auth_repository.dart';
import '../../widgets/gender_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late EditProfileCubit cubit;

  @override
  void initState() {
    cubit = EditProfileCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      bloc: cubit,
      listener: (context, state) {
        if (state.status == EditProfileStatus.updatedSuccessfully) {
          context.pop(true);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state.status == EditProfileStatus.loading
              ? const LoadingPanel()
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).padding.top + 30.h,
                        horizontal: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            CustomBackButton(
                              color: context.isDark
                                  ? AppColors.white
                                  : AppColors.black,
                              size: 20.w,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 35.h,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              selectImage();
                            },
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: 100.w,
                                  height: 100.w,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(150.r),
                                    child: CustomNetworkImage(
                                      url: state.selectedImage ??
                                          state.profileModel!.profilePhoto ??
                                          "",
                                      isLoad: state.selectedImage != null
                                          ? true
                                          : false,
                                      boxFit: BoxFit.cover,
                                      errorIcon: Assets.icons.person,
                                      borderRadius: BorderRadius.zero,
                                      backgroundColor:
                                          HexColor.fromHex('#EFF3F5'),
                                      errorPadding: 1,
                                      isBase64: state.selectedImage == null
                                          ? true
                                          : false,
                                    ),
                                  ),
                                ),
                                PositionedDirectional(
                                  end: -8.h,
                                  bottom: 5.h,
                                  child: GestureDetector(
                                    onTap: () {
                                      selectImage();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5.w),
                                      decoration: BoxDecoration(
                                          color: AppMaterialColors.green[150]!,
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: CustomSvgIcon(
                                          Assets.icons.editProfileIcon,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          state.profileModel!.name ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 18.sp),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        if (state.status == EditProfileStatus.error)
                          ErrorBanner(failure: state.failure!),
                        SizedBox(
                          height: 40.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "profile.General Information".tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Form(
                          key: state.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "failures.otp.full_name".tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        color: HexColor.fromHex('#77738F'),
                                        fontSize: 13.sp),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomFormField(
                                validator: ValidationService
                                    .requiredFullNameFieldValidator,
                                autoValidate: true,
                                controller: state.textEditingController,
                                boarderRadius: 12.r,
                                maxLength: cubit.state.textEditingController
                                            .text.length >=
                                        30
                                    ? 30
                                    : null,
                                fillColor: HexColor.fromHex('#F9FAFF'),
                                hintText:
                                    "failures.otp.enter_your_full_name".tr(),
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        color: HexColor.fromHex('#B0AEC9'),
                                        fontSize: 13.sp),
                                onChange: (p0) {
                                  cubit.checkMaxFiledLength();
                                },
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                "sign_up.phone_number".tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        color: HexColor.fromHex('#77738F'),
                                        fontSize: 13.sp),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: CustomFormField(
                                  readOnly: true,
                                  onChange: cubit.onChangeNumber,
                                  hintText: state.profileModel!.mobileNumber ??
                                      "(xx) xxx-xxxx".tr(),
                                  autoValidate: state.validateField,
                                  boarderRadius: 12.r,
                                  fillColor: HexColor.fromHex('#F9FAFF'),
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
                                          enable: false,
                                          countries: state.countries ?? [],
                                          withPhoneNumber: false,
                                          validateField: state.validateField,
                                          onChange: (phoneNumberModel) {
                                            cubit.onPhoneCodeChanged;
                                          },
                                          phoneNumberModel:
                                              state.phoneNumberModel!,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
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
                                height: 15.h,
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
                                    width: 15.w,
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
                                height: 60.h,
                              ),
                              CustomContainer(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                borderRadius: 10,
                                gradient: AppGradients.continerGradient,
                                child: TextButton(
                                  child: Text(
                                    "sign_up.save_changes".tr(),
                                    style: TextStyle(
                                        color: AppMaterialColors.white,
                                        fontSize: 14.sp),
                                  ),
                                  onPressed: () async {
                                    if (!(state.formKey.currentState!
                                        .validate())) {
                                      state.enableValidation();
                                    } else {
                                      cubit
                                          .updateProfile(state.selectedImage)
                                          .then((onValue) {
                                        BlocProvider.of<MainPageCubit>(context)
                                            .getUserInfo();
                                      });
                                    }
                                  },
                                ),
                              ),
                              if (cubit.state.status !=
                                  EditProfileStatus.loading)
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    InkWell(
                                      onTap: () =>
                                          _showLanguageChooser(context),
                                      child: Center(
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.arrow_drop_down,
                                                size: 20.sp,
                                                color:
                                                    HexColor.fromHex('#C1C7D0'),
                                              ),
                                              SizedBox(
                                                  width: 25.w,
                                                  height: 25.w,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100.r),
                                                    child: CustomSvgIcon(context
                                                            .isArabic
                                                        ? Assets
                                                            .icons.uaeFlagCricel
                                                        : Assets.icons
                                                            .englishFlagCircle),
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
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).padding.bottom,
                                    ),
                                  ],
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  selectImage() {
    BottomSheetHelper.showPickPhotoBottomSheet(
        context: context,
        title: "sign_up.select_image".tr(),
        pickFromCamera: () async {
          final image =
              await ImageFilePickerService.getInstance().pickImageFromCamera();

          if (image != null) {
            cubit.onSelectImage(image);
          }
        },
        pickFromGallery: () async {
          final image = await ImageFilePickerService.getInstance()
              .pickImageFromGallery(imageQuality: 50);

          if (image != null) {
            cubit.onSelectImage(image);
          }
        });
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
}
