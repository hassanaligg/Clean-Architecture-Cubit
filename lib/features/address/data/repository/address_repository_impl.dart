import 'package:dawaa24/features/address/data/model/address_model.dart';
import 'package:dawaa24/features/address/domain/params/add_address_params.dart';
import 'package:dawaa24/features/address/domain/repository/address_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/model/base_response_model.dart';
import '../../domain/params/get_address_list_params.dart';
import '../remote_datasource/address_remote_datasource.dart';

@Singleton(as: AddressRepository)
class ReadingRepositoryImpl implements AddressRepository {
  final AddressRemoteDataSource addressRemoteDataSource;

  const ReadingRepositoryImpl(
    this.addressRemoteDataSource,
  );

  @override
  Future<Page<AddressModel>> getAddressList(GetAddressListParams params) async {
    final res = await addressRemoteDataSource.getAddressList(params);
    return res.data!;
  }

  @override
  Future<AddressModel> addAddress(AddAddressParams params) async {
    final res = await addressRemoteDataSource.addAddress(params);
    return res.data!;
  }

  @override
  Future<AddressModel> updateAddress(AddAddressParams params) async {
    final res = await addressRemoteDataSource.updateAddress(params);
    return res.data!;
  }

  @override
  Future<bool> makeAddressDefault(String addressId) async {
    final res = await addressRemoteDataSource.makeAddressDefault(addressId);
    return true;
  }

  @override
  Future<bool> deleteAddress(String addressId) async {
    final res = await addressRemoteDataSource.deleteAddress(addressId);
    return true;
  }
}
