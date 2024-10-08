import 'package:dawaa24/core/domain/usecase/usecase.dart';
import 'package:dawaa24/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';


@injectable
class LogOutUseCase extends UseCase<bool, NoParams> {
  final AuthRepository repository;

  LogOutUseCase({required this.repository});

  @override
  Future<bool> call(params) async {
    var result = await repository.logOut(withToken: true);
    return result;
  }
}
