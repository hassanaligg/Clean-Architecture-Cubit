import 'package:dawaa24/core/domain/usecase/usecase.dart';
import 'package:dawaa24/features/address/data/model/address_model.dart';
import 'package:dawaa24/features/address/domain/params/add_address_params.dart';
import 'package:dawaa24/features/address/domain/repository/address_repository.dart';
import 'package:injectable/injectable.dart';


@injectable
class AddAddressUseCase extends UseCase<AddressModel, AddAddressParams> {
  final AddressRepository repository;

  AddAddressUseCase({required this.repository});

  @override
  Future<AddressModel> call(params) async {
    return repository.addAddress(params);
  }
}
