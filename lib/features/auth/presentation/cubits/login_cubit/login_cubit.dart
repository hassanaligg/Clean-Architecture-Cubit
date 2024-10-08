/*
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dawaa24/core/domain/usecase/usecase.dart';
import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';
import 'package:dawaa24/core/services/local_authentication_biometrics_service.dart';
import 'package:dawaa24/core/utils/constants.dart';
import 'package:dawaa24/core/utils/failures/failures.dart';
import 'package:dawaa24/di/injection.dart';
import 'package:dawaa24/features/auth/domain/params/login_params.dart';
import 'package:dawaa24/features/auth/domain/usecase/check_if_device_has_biometrics_usecase.dart';
import 'package:dawaa24/features/auth/domain/usecase/check_if_has_biometrics_usecase.dart';
import 'package:dawaa24/features/auth/domain/usecase/get_login_params_biometrics_usecase.dart';
import 'package:dawaa24/features/auth/domain/usecase/get_user_info_usecase.dart';
import 'package:dawaa24/features/auth/domain/usecase/save_login_params_usecase.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/usecase/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.initial()) {
    loginUseCase = getIt<LoginUseCase>();
    _getLogInParamBiometricsUseCase = getIt<GetLogInParamBiometricsUseCase>();
    _checkIfHasBiometricsUseCase = getIt<CheckIfHasBiometricsUseCase>();
    _saveLoginParamsUseCase = getIt<SaveLoginParamsUseCase>();
    _localAuthenticationBiometricsService =
        getIt<LocalAuthenticationBiometricsService>();
    _checkIfDeviceHasBiometricsUseCase =
        getIt<CheckIfDeviceHasBiometricsUseCase>();
    initializeFunctions();
  }

  late LoginUseCase loginUseCase;
  late GetUserInfoUseCase getUserInfoUseCase;
  late GetLogInParamBiometricsUseCase _getLogInParamBiometricsUseCase;
  late CheckIfHasBiometricsUseCase _checkIfHasBiometricsUseCase;
  late CheckIfDeviceHasBiometricsUseCase _checkIfDeviceHasBiometricsUseCase;
  late SaveLoginParamsUseCase _saveLoginParamsUseCase;
  late LocalAuthenticationBiometricsService
      _localAuthenticationBiometricsService;

  submit() async {
    if (!(state.formKey.currentState!.validate())) {
      emit(state.enableValidation());
    } else {
      emit(state.changeState(LoginStatus.loading));

      try {
        await loginUseCase(state.params);
        if (state.saveInfoWithBiometrics) {
          _saveLoginParamsUseCase.call(state.params);
        }
        emit(state.changeState(LoginStatus.success));
      } on Failure catch (l) {
        emit(state.loginError(l));
      }
    }
  }

  changePasswordVisibility() {
    emit(state.copyWith(isHidden: !(state.isHidden)));
  }

  saveLogInCredentialByBiometrics() {
    emit(state.copyWith(saveInfoWithBiometrics: !state.saveInfoWithBiometrics));
  }

  onChangeEmail(String val) {
    emit(state.emailChanged(val));
  }

  onChangePassword(String val) {
    emit(state.passwordChanged(val));
  }

  checkIfHasBiometrics() async {
    emit(state.changeHasBiometrics(
        await _checkIfHasBiometricsUseCase.call(NoParams())));
  }

  checkIfItHasDataSavedByBiometrics() async {
    emit(state.copyWith(
        hasBiometricsData:
            await _checkIfDeviceHasBiometricsUseCase.call(NoParams())));
    emit(state);
  }

  submitLogInUsingBiometrics() async {
    if (state.hasBiometricsData == false) {
      Fluttertoast.showToast(
          msg: 'sign_in.pleasLoginAndApplyRememberCredentialFirst'.tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
      return;
    }
    try {
      if (await _localAuthenticationBiometricsService
          .callBiometricsAndCheckResult()) {
        emit(state.changeState(LoginStatus.loading));
        emit(state.copyWith(
            params: await _getLogInParamBiometricsUseCase.call(NoParams())));
        try {
          await loginUseCase(state.params);
          emit(state.changeState(LoginStatus.success));
        } on Failure catch (l) {
          emit(state.loginError(l));
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'sign_in.forSecurityReasonPleaseLoginUsingEmailAndPassword'.tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    }
  }

  initializeFunctions() async {
    await checkIfHasBiometrics();
    await checkIfItHasDataSavedByBiometrics();
  }

  openWhatsapp() async {
    if (await canLaunchUrl(
        Uri.parse(state.whatsappURl + state.whatsappMobileNumber))) {
      await launchUrl(
          Uri.parse(state.whatsappURl + state.whatsappMobileNumber));
    } else {
      Fluttertoast.showToast(
          msg: "whatsapp no installed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppMaterialColors.green.shade100,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
*/
