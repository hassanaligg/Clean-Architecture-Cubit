import 'package:dawaa24/core/domain/usecase/usecase.dart';
import 'package:dawaa24/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangeLanguageUseCase extends UseCase<bool, bool> {
  final AuthRepository repository;

  ChangeLanguageUseCase({required this.repository});

  @override
  Future<bool> call(params) async {
    //1:Arabic : 0:English
    var result = await repository
        .changeLanguage({"applicationLanguage": params ? 1 : 0});
    return result;
  }
}
