import 'package:dawaa24/core/domain/usecase/usecase.dart';
import 'package:dawaa24/features/pharmacies/domain/repository/pharmacy_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddToMyPharmacyUseCase extends UseCase<String, String> {
  final PharmaciesRepository repository;

  AddToMyPharmacyUseCase({required this.repository});

  @override
  Future<String> call(params) async {
    return repository.addToMyPharmacy(params);
  }
}
