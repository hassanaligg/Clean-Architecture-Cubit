import 'package:dawaa24/core/domain/usecase/usecase.dart';
import 'package:dawaa24/core/services/local_authentication_biometrics_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckIfHasBiometricsUseCase extends UseCase<bool, NoParams> {
  final LocalAuthenticationBiometricsService _localAuthenticationBiometricsService;

  CheckIfHasBiometricsUseCase(this._localAuthenticationBiometricsService);

  @override
  Future<bool> call(NoParams params) async{
    return await _localAuthenticationBiometricsService.checkIfHasBiometrics();
  }
}
