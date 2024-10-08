import 'package:dawaa24/core/utils/constants.dart';
import 'package:dawaa24/features/address/data/model/address_model.dart';
import 'package:dawaa24/features/address/domain/params/add_address_params.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/data/datasource/base_remote_datasource.dart';
import '../../../../../core/data/model/base_response_model.dart';
import '../../domain/params/get_address_list_params.dart';
import 'address_remote_datasource.dart';

@Singleton(as: AddressRemoteDataSource)
class AddressRemoteDataSourceImpl extends BaseRemoteDataSourceImpl
    implements AddressRemoteDataSource {
  String addressListEndPoint =
      '${AppConstant.baseUrl}/api/app/patients/GetPatientAddresses';
  String addAddressEndPoint =
      '${AppConstant.baseUrl}/api/app/patients/CreatePatientAddress';
  String updateAddressEndPoint =
      '${AppConstant.baseUrl}/api/app/patients/UpdatePatientAddress';

  String makeAddressDefaultEndPoint =
      '${AppConstant.baseUrl}/api/app/patients/SetAddressAsDefault';
  String deleteAddressEndPoint =
      '${AppConstant.baseUrl}/api/app/patients/DeleteAddress';

  AddressRemoteDataSourceImpl({required super.dio});

  @override
  Future<BaseResponse<Page<AddressModel>>> getAddressList(
      GetAddressListParams addressListParams) async {
    final res = await get(
        url: addressListEndPoint,
        decoder: (json) {
          var res = Page.fromJson(json, AddressModel.fromJson,
              ListKeysPage.items);
          return res;
        },
        params: addressListParams.toJson(),
        requiredToken: true);

    return res;
  }

  @override
  Future<BaseResponse<AddressModel>> addAddress(AddAddressParams params) async {
    final res = await post(
      url: addAddressEndPoint,
      body: params.toJson(),
      decoder: (json) => AddressModel.fromJson(json),
      requiredToken: true,
    );
    return res;
  }

  @override
  Future<BaseResponse> updateAddress(AddAddressParams params) async {
    final res = await put(
      url: updateAddressEndPoint,
      body: params.toJson(),
      decoder: (json) => AddressModel.fromJson(json),
      requiredToken: true,
    );
    return res;
  }

  @override
  Future<BaseResponse> makeAddressDefault(String addressId) async {
    final res = await put(
      url: "$makeAddressDefaultEndPoint?addressId=$addressId",
      decoder: (json) =>{},
      requiredToken: true,
    );
    return res;
  }

  @override
  Future<BaseResponse> deleteAddress(String addressId) async {
    final res = await delete(
      url: "$deleteAddressEndPoint?id=$addressId",
      decoder: (json) => {},
      requiredToken: true,
    );
    return res;
  }
}
