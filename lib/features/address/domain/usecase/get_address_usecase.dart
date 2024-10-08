import 'package:dawaa24/core/domain/usecase/usecase.dart';
import 'package:dawaa24/features/address/data/model/address_model.dart';
import 'package:dawaa24/features/address/domain/params/get_address_list_params.dart';
import 'package:dawaa24/features/address/domain/repository/address_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/model/base_response_model.dart';

@injectable
class GetAddressListUseCase
    extends UseCase<Page<AddressModel>, GetAddressListParams> {
  final AddressRepository repository;

  GetAddressListUseCase({required this.repository});

  @override
  Future<Page<AddressModel>> call(params) async {
    return repository.getAddressList(params);
  }
}
