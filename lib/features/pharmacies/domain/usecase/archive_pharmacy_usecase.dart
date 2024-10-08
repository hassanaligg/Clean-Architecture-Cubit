import 'package:dawaa24/core/domain/usecase/usecase.dart';
import 'package:dawaa24/features/pharmacies/domain/repository/pharmacy_repository.dart';
import 'package:injectable/injectable.dart';


@injectable
class ArchivePharmaciesUseCase extends UseCase<bool, String> {
  final PharmaciesRepository repository;

  ArchivePharmaciesUseCase({required this.repository});

  @override
  Future<bool> call(params) async {
    return repository.archivePharmacy(params);
  }
}
