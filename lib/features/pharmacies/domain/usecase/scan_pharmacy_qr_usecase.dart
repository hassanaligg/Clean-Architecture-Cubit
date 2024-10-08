import 'package:dawaa24/core/domain/usecase/usecase.dart';
import 'package:dawaa24/features/pharmacies/data/model/pharmacie_model.dart';
import 'package:dawaa24/features/pharmacies/domain/repository/pharmacy_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ScanPharmacyQRUseCase extends UseCase<PharmacyModel, String> {
  final PharmaciesRepository repository;

  ScanPharmacyQRUseCase({required this.repository});

  @override
  Future<PharmacyModel> call(params) async {
    return repository.scanPharmacyQR(params);
  }
}

