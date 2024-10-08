import 'package:dawaa24/features/address/data/model/address_model.dart';

import '../../../../core/data/model/base_response_model.dart';
import '../params/add_address_params.dart';
import '../params/get_address_list_params.dart';

abstract class AddressRepository {
  Future<Page<AddressModel>> getAddressList(GetAddressListParams params);

  Future<AddressModel> addAddress(AddAddressParams params);

  Future<AddressModel> updateAddress(AddAddressParams params);

  Future<bool> makeAddressDefault(String addressId);

  Future<bool> deleteAddress(String addressId);
}
