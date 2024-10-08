import 'package:dawaa24/core/domain/usecase/usecase.dart';
import 'package:dawaa24/features/address/domain/repository/address_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class MakeAddressDefaultUseCase extends UseCase<bool, String> {
  final AddressRepository repository;

  MakeAddressDefaultUseCase({required this.repository});

  @override
  Future<bool> call(String params) async {
    return repository.makeAddressDefault(params);
  }
}
