import 'package:dawaa24/core/domain/usecase/usecase.dart';
import 'package:dawaa24/features/pharmacies/data/model/pharmacie_model.dart';
import 'package:dawaa24/features/pharmacies/domain/repository/pharmacy_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPharmacyDetailsUseCase extends UseCase<PharmacyModel, String> {
  final PharmaciesRepository repository;

  GetPharmacyDetailsUseCase({required this.repository});

  @override
  Future<PharmacyModel> call(params) async {
    return repository.getPharmacyDetails(params);
  }
}
