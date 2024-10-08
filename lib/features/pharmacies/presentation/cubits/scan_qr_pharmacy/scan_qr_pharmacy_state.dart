part of 'scan_qr_pharmacy_cubit.dart';

enum ScanQrPharmacyStatus {
  initial,
  loading,
  error,
  success,
}

class ScanQrPharmacyState {
  final ScanQrPharmacyStatus status;
  final Failure? failure;
  final CameraPermissionStatusEnum cameraPermissionStatus;
  final PharmacyModel? pharmacyModel;

  ScanQrPharmacyState._({
    required this.status,
    this.failure,
    this.pharmacyModel,
    required this.cameraPermissionStatus,
  });

  ScanQrPharmacyState.initial()
      : status = ScanQrPharmacyStatus.initial,
        pharmacyModel = null,
        cameraPermissionStatus =
            CameraPermissionStatusEnum.cameraPermissionUnknown,
        failure = null;

  ScanQrPharmacyState reSetFailure() {
    return ScanQrPharmacyState._(
      failure: null,
      pharmacyModel: null,
      status: ScanQrPharmacyStatus.initial,
      cameraPermissionStatus: cameraPermissionStatus,
    );
  }

  copyWith(
      {ScanQrPharmacyStatus? status,
      Failure? failure,
      PharmacyModel? pharmacyModel,
      CameraPermissionStatusEnum? cameraPermissionStatus}) {
    return ScanQrPharmacyState._(
        status: status ?? this.status,
        pharmacyModel: pharmacyModel ?? this.pharmacyModel,
        failure: failure ?? this.failure,
        cameraPermissionStatus:
            cameraPermissionStatus ?? this.cameraPermissionStatus);
  }
}
