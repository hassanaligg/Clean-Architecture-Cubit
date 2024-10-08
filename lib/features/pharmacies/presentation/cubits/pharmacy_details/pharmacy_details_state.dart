part of 'pharmacy_details_cubit.dart';

enum PharmacyDetailsStatus {
  initial,
  loading,
  addToMyPharmacyLoading,
  addToMyPharmacyError,
  error,
  success,
}

class PharmacyDetailsState {
  final PharmacyDetailsStatus status;
  final Failure? failure;
  final Failure? addToMyPharmacyFailure;
  final PharmacyModel? pharmacyModel;

  PharmacyDetailsState._(
      {required this.status,
      this.failure,
      this.pharmacyModel,
      this.addToMyPharmacyFailure});

  PharmacyDetailsState.initial()
      : status = PharmacyDetailsStatus.success,
        pharmacyModel = null,
        addToMyPharmacyFailure = null,
        failure = null;

  copyWith(
      {PharmacyDetailsStatus? status,
      Failure? failure,
      Failure? addToMyPharmacyFailure,
      PharmacyModel? pharmacyModel}) {
    return PharmacyDetailsState._(
        status: status ?? this.status,
        addToMyPharmacyFailure:
            addToMyPharmacyFailure ?? this.addToMyPharmacyFailure,
        failure: failure ?? this.failure,
        pharmacyModel: pharmacyModel ?? this.pharmacyModel);
  }
}
