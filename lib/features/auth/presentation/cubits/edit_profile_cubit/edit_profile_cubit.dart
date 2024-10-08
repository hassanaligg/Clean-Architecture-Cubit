import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dawaa24/core/domain/usecase/usecase.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/data/model/phone_number_model.dart';
import '../../../../../core/utils/failures/base_failure.dart';
import '../../../../../di/injection.dart';
import '../../../../main/presentation/cubits/main_page_cubit/main_page_cubit.dart';
import '../../../data/model/country_model.dart';
import '../../../data/model/profile_model.dart';
import '../../../domain/params/update_patient_info_params.dart';
import '../../../domain/usecase/get_user_info_usecase.dart';
import '../../../domain/usecase/update_patient_info_usecase.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileState.initial()) {
    _getUserInfoUseCase = getIt<GetUserInfoUseCase>();
    _updatePatientInfoUseCase = getIt<UpdatePatientInfoUseCase>();
    getUserInfo();
  }

  late GetUserInfoUseCase _getUserInfoUseCase;
  late UpdatePatientInfoUseCase _updatePatientInfoUseCase;

  Future<void> updateProfile(String? image) async {
    if (!(state.formKey.currentState!.validate())) {
      enableValidation();
    } else {
      emit(state.copyWith(status: EditProfileStatus.loading));

      try {
        await _updatePatientInfoUseCase(UpdatePatientInfoParams(
            name: state.textEditingController.text,
            gender: state.selectedGender!,
            profilePhoto: state.selectedImage));
        emit(state.copyWith(
            status: EditProfileStatus.updatedSuccessfully,
            selectedImage: state.selectedImage));
        "sign_up.profile_updated_successfully".tr().showToast();

        // emit(state.disableValidation());
      } on Failure catch (l) {
        emit(state.copyWith(failure: l, status: EditProfileStatus.error));
      }
    }
  }

  getUserInfo() async {
    emit(state.copyWith(status: EditProfileStatus.loading));

    try {
      ProfileModel profile = await _getUserInfoUseCase(NoParams());
      emit(state.copyWith(
          status: EditProfileStatus.success,
          profileModel: profile,
          selectedGender: profile.gender,
          textEditingController: TextEditingController(text: profile.name)));
    } on Failure catch (l) {
      emit(state.copyWith(failure: l, status: EditProfileStatus.error));
    }
  }

  onChangeNumber(String number) {
    emit(state.copyWith(
        phoneNumberModel:
            state.phoneNumberModel!.copyWith(phoneNumber: number)));
  }

  onPhoneCodeChanged(PhoneNumberModel val) {
    emit(state.copyWith(phoneNumberModel: val));
  }

  onChangeSelectedGender(int id) {
    emit(state.copyWith(selectedGender: id));
  }

  checkMaxFiledLength() {
    if (state.textEditingController.text.length >= 1000) {
      emit(state.copyWith(maxFiledLength: true));
    } else {
      emit(state.copyWith(maxFiledLength: false));
    }
  }

  enableValidation() {
    emit(state.enableValidation());
  }

  onSelectImage(File image) {
    emit(state.copyWith(selectedImage: image.path));
  }
}
