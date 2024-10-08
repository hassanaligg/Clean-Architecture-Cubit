import 'package:dawaa24/features/address/data/model/address_model.dart';
import 'package:dawaa24/features/address/domain/params/add_address_params.dart';
import '../../../../../core/data/model/base_response_model.dart';
import '../../domain/params/get_address_list_params.dart';

abstract class AddressRemoteDataSource {
  Future<BaseResponse<Page<AddressModel>>> getAddressList(
      GetAddressListParams addressListParams);

  Future<BaseResponse<AddressModel>> addAddress(AddAddressParams params);

  Future<BaseResponse> updateAddress(AddAddressParams params);

  Future<BaseResponse> deleteAddress(String addressId);

  Future<BaseResponse> makeAddressDefault(String addressId);
}
