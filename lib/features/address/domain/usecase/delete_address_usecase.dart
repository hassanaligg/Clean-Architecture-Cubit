import 'package:dawaa24/core/domain/usecase/usecase.dart';

import 'package:dawaa24/features/address/domain/repository/address_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteAddressUseCase extends UseCase<bool, String> {
  final AddressRepository repository;

  DeleteAddressUseCase({required this.repository});

  @override
  Future<bool> call(params) async {
    return repository.deleteAddress(params);
  }
}
