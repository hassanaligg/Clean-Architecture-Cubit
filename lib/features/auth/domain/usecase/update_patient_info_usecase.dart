import 'package:dawaa24/core/domain/usecase/usecase.dart';
import 'package:dawaa24/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

import '../params/update_patient_info_params.dart';

@injectable
class UpdatePatientInfoUseCase extends UseCase<bool, UpdatePatientInfoParams> {
  final AuthRepository repository;

  UpdatePatientInfoUseCase({required this.repository});

  @override
  Future<bool> call(params) async {
    var result = await repository.updatePatientInfo(params);
    return result;
  }
}
