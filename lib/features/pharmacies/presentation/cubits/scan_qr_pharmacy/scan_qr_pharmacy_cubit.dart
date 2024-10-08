import 'package:bloc/bloc.dart';
import 'package:dawaa24/core/data/enums/camera_permission_status_enum.dart';
import 'package:dawaa24/core/presentation/services/validation_service.dart';
import 'package:dawaa24/core/utils/failures/base_failure.dart';
import 'package:dawaa24/di/injection.dart';
import 'package:dawaa24/features/pharmacies/data/model/pharmacie_model.dart';
import 'package:dawaa24/features/pharmacies/domain/usecase/scan_pharmacy_qr_usecase.dart';

part 'scan_qr_pharmacy_state.dart';

class ScanQrPharmacyCubit extends Cubit<ScanQrPharmacyState> {
  ScanQrPharmacyCubit() : super(ScanQrPharmacyState.initial()) {
    _scanPharmacyQRUseCase = getIt<ScanPharmacyQRUseCase>();
  }

  late ScanPharmacyQRUseCase _scanPharmacyQRUseCase;

  scanPharmacyQR(String providerCode) async {
    if (ValidationService.wrongQRValidator(providerCode) != null) {
      Failure temp = ValidationService.wrongQRValidator(providerCode)!;
      emit(state.copyWith(failure: temp, status: ScanQrPharmacyStatus.error));
    } else {
      emit(state.copyWith(status: ScanQrPharmacyStatus.loading));

      try {
        var tempPharmacyModel = await _scanPharmacyQRUseCase(providerCode);
        tempPharmacyModel = tempPharmacyModel.copyWith(isComingFromQr: true);
        emit(state.copyWith(status: ScanQrPharmacyStatus.success,pharmacyModel: tempPharmacyModel));
      } on Failure catch (l) {
        emit(state.copyWith(failure: l, status: ScanQrPharmacyStatus.error));
      }
    }
  }

  reSetFailure() {
    emit(state.reSetFailure());
  }

  void changeCameraPermissionStatus(
      CameraPermissionStatusEnum cameraPermissionStatus) {
    emit(state.copyWith(cameraPermissionStatus: cameraPermissionStatus));
  }
}
