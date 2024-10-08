
import '../../../features/auth/data/model/country_model.dart';

class PhoneNumberModel {
  CountryModel countryModel;
  String phoneNumber;

  PhoneNumberModel({
    required this.countryModel,
    required this.phoneNumber,
  });

  PhoneNumberModel.initial()
      : countryModel = CountryModel(
            code: "+971",
            flag: CountryModel.getFlagEmoji("AE"),
            name: "UAE"),
        phoneNumber = '';

  @override
  String toString() {
    return '${countryModel.code}$phoneNumber';
  }

  PhoneNumberModel copyWith({
    CountryModel? countryModel,
    String? phoneNumber,
  }) {
    return PhoneNumberModel(
      countryModel: countryModel ?? this.countryModel,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
