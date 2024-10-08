import 'package:dawaa24/core/domain/usecase/usecase.dart';
import 'package:dawaa24/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/profile_model.dart';

@injectable
class GetUserInfoUseCase extends UseCase<ProfileModel, NoParams> {
  final AuthRepository repository;

  GetUserInfoUseCase({required this.repository});

  @override
  Future<ProfileModel> call(params) async {
    var result = await repository.loadRemoteUserInfo();
    return result;
  }
}
