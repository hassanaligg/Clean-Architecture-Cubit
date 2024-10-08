import 'package:dawaa24/core/domain/usecase/usecase.dart';
import 'package:dawaa24/features/auth/domain/params/login_params.dart';
import 'package:dawaa24/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ReSendOtpUseCase extends UseCase<bool, LoginParams> {
  final AuthRepository repository;

  ReSendOtpUseCase({required this.repository});

  @override
  Future<bool> call(params) async {
    var result = await repository.sendOtp(params.toJson());
    return result;
  }
}
