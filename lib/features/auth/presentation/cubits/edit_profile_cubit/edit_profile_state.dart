part of 'edit_profile_cubit.dart';

enum EditProfileStatus { initial, loading, success, error,updatedSuccessfully }

class EditProfileState {
  final EditProfileStatus status;
  final Failure? failure;
  final PhoneNumberModel? phoneNumberModel;
  final bool validateField;
  final List<CountryModel>? countries;
  final int? selectedGender;
  GlobalKey<FormState> formKey;
  final TextEditingController textEditingController;
  final ProfileModel? profileModel;
  final String? selectedImage;

  EditProfileState._({
    required this.status,
    required this.phoneNumberModel,
    this.validateField = false,
    required this.formKey,
    this.failure,
    this.countries,
    required this.textEditingController,
    this.selectedGender,
    this.profileModel,
    this.selectedImage,
  });

  EditProfileState.initial()
      : status = EditProfileStatus.initial,
        phoneNumberModel = PhoneNumberModel.initial(),
        validateField = false,
        selectedGender = 0,
        textEditingController = TextEditingController(),
        formKey = GlobalKey<FormState>(),
        countries = [],
        profileModel = null,
        selectedImage = null,
        failure = null;

  EditProfileState enableValidation() {
    return copyWith(validateField: true);
  }

  copyWith({
    EditProfileStatus? status,
    Failure? failure,
    PhoneNumberModel? phoneNumberModel,
    bool? validateField,
    List<CountryModel>? countries,
    TextEditingController? textEditingController,
    int? selectedGender,
    bool? maxFiledLength,
    ProfileModel? profileModel,
    String? selectedImage,
    GlobalKey<FormState>? formKey,
  }) {
    return EditProfileState._(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      phoneNumberModel: phoneNumberModel ?? this.phoneNumberModel,
      validateField: validateField ?? this.validateField,
      countries: countries ?? this.countries,
      selectedImage: selectedImage ?? this.selectedImage,
      textEditingController:
          textEditingController ?? this.textEditingController,
      selectedGender: selectedGender ?? this.selectedGender,
      profileModel: profileModel ?? this.profileModel,
      formKey: formKey ?? this.formKey,
    );
  }
}
