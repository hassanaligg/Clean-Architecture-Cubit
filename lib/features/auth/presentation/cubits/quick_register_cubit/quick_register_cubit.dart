import 'package:bloc/bloc.dart';
import 'package:dawaa24/core/domain/usecase/usecase.dart';
import 'package:dawaa24/core/services/agora_service.dart';
import 'package:dawaa24/di/injection.dart';
import 'package:dawaa24/features/auth/domain/params/login_params.dart';
import 'package:dawaa24/features/auth/domain/usecase/login_usecase.dart';
import 'package:dawaa24/features/auth/domain/usecase/resend_otp_usecase.dart';
import 'package:dawaa24/features/auth/domain/usecase/verify_otp_usecase.dart';
import 'package:flutter/material.dart';

import '../../../../../core/data/model/phone_number_model.dart';
import '../../../../../core/utils/failures/base_failure.dart';
import '../../../data/model/country_model.dart';
import '../../../domain/params/update_patient_info_params.dart';
import '../../../domain/usecase/get_countries_usecase.dart';
import '../../../domain/usecase/update_patient_info_usecase.dart';

part 'quick_register_state.dart';

class QuickRegisterCubit extends Cubit<QuickRegisterState> {
  QuickRegisterCubit() : super(QuickRegisterState.initial()) {
    _loginUseCase = getIt<LoginUseCase>();
    _verifyOtpUseCase = getIt<VerifyOtpUseCase>();
    _reSendOtpUseCase = getIt<ReSendOtpUseCase>();
    _getCountriesUseCase = getIt<GetCountriesUseCase>();
    _updatePatientInfoUseCase = getIt<UpdatePatientInfoUseCase>();
    _agoraService = getIt<AgoraService>();
    getFlags();
  }

  late LoginUseCase _loginUseCase;
  late VerifyOtpUseCase _verifyOtpUseCase;
  late ReSendOtpUseCase _reSendOtpUseCase;
  late GetCountriesUseCase _getCountriesUseCase;
  late UpdatePatientInfoUseCase _updatePatientInfoUseCase;
  late AgoraService _agoraService;

  enableValidation() {
    emit(state.enableValidation());
  }

  submit() async {
    if (!(state.formKey.currentState!.validate())) {
      enableValidation();
    } else {
      emit(state.changeState(QuickRegisterStatus.loading));

      try {
        await _loginUseCase(LoginParams(
            mobileNumber: state.phoneNumberModel!.phoneNumber,
            countryCode: state.phoneNumberModel!.countryModel.code!));
        emit(state.changeState(QuickRegisterStatus.success));
        emit(state.disableValidation());
        toOtpPage();
      } on Failure catch (l) {
        emit(state.copyWith(failure: l, status: QuickRegisterStatus.error));
      }
    }
  }

  verifyAccount(String fullName) async {
    if (!(state.formKey.currentState!.validate())) {
      enableValidation();
    } else {
      emit(state.changeState(QuickRegisterStatus.loading));
      try {
        await _updatePatientInfoUseCase(UpdatePatientInfoParams(
            name: fullName, gender: state.selectedGender!));
        emit(state.changeState(QuickRegisterStatus.success));
        emit(state.disableValidation());
        await _agoraService.initSDK();
      } on Failure catch (l) {
        emit(state.copyWith(failure: l, status: QuickRegisterStatus.error));
      }
    }
  }

  submitVerifyOtp() async {
    {
      emit(state.changeState(QuickRegisterStatus.loading));

      try {
        await _verifyOtpUseCase(LoginParams(
            mobileNumber: state.phoneNumberModel!.phoneNumber,
            countryCode: state.phoneNumberModel!.countryModel.code!,
            code: state.otp));
        await _agoraService.initSDK();

        emit(state.changeState(QuickRegisterStatus.verifyOtpSuccess));
      } on Failure catch (l) {
        emit(state.copyWith(
            failure: l, status: QuickRegisterStatus.verifyOtpError));
      }
    }
  }

  reSendOtp() async {
    {
      try {
        await _reSendOtpUseCase(LoginParams(
            mobileNumber: state.phoneNumberModel!.phoneNumber,
            countryCode: state.phoneNumberModel!.countryModel.code!));
        emit(state.changeState(QuickRegisterStatus.resendOtpSuccess));
      } on Failure catch (l) {
        emit(state.copyWith(
            failure: l, status: QuickRegisterStatus.verifyOtpError));
      }
    }
  }

  onPhoneCodeChanged(PhoneNumberModel val) {
    emit(state.copyWith(phoneNumberModel: val));
  }

  onChangeNumber(String number) {
    emit(state.phoneNumberChanged(number));
  }

  changeStatus(QuickRegisterStatus status) {
    emit(state.copyWith(status: status));
  }

  onOTPChanged(String otp) {
    emit(state.copyWith(otp: otp));
  }

  onChangeSelectedGender(int id) {
    emit(state.copyWith(selectedGender: id));
  }

  Future<bool> toOtpPage() async {
    changeStatus(QuickRegisterStatus.sendOtpSuccess);
    return true;
  }

  getFlags() async {
    emit(state.changeState(QuickRegisterStatus.getCountriesLoading));
    try {
      var countries = await _getCountriesUseCase(NoParams());
      int indexToRemove =
          countries.indexWhere((country) => country.isoCode2 == "UNSPECIFIED");
      if (indexToRemove != -1) {
        countries.removeAt(indexToRemove);
      }
      emit(state.copyWith(countries: countries));
      emit(state.changeState(QuickRegisterStatus.error));
    } on Failure catch (l) {
      emit(state.copyWith(
          failure: l, status: QuickRegisterStatus.verifyOtpError));
    }
  }
}
