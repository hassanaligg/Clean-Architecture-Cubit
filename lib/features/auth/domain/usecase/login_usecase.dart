import 'package:dawaa24/core/domain/usecase/usecase.dart';
import 'package:dawaa24/features/auth/domain/params/login_params.dart';
import 'package:dawaa24/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase extends UseCase<bool, LoginParams> {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<bool> call(params) async {
    var result = await repository.login(params.toJson());
    return result;
  }
}
