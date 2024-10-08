import 'package:dawaa24/core/data/model/base_response_model.dart';
import 'package:dawaa24/core/utils/constants.dart';
import 'package:dawaa24/features/pharmacies/data/datasource/remote_datasource/pharmacies_remote_datasource.dart';
import 'package:dawaa24/features/pharmacies/data/model/pharmacie_model.dart';
import 'package:dawaa24/features/pharmacies/domain/params/get_pharmacies_list_params.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/data/datasource/base_remote_datasource.dart';

@Singleton(as: PharmaciesRemoteDataSource)
class PharmaciesDataSourceImpl extends BaseRemoteDataSourceImpl
    implements PharmaciesRemoteDataSource {
  String getPharmaciesListEndPoint =
      '${AppConstant.baseUrl}/api/app/patients/GetPharmacies';
  String addToMyPharmacyEndPoint =
      '${AppConstant.baseUrl}/api/app/patients/AddToMyPharmacies';

  String getArchivePharmaciesListEndPoint =
      '${AppConstant.baseUrl}/api/app/patients/GetMyArchivePharmacies';

  String scanPharmacyQREndPoint =
      '${AppConstant.baseUrl}/api/app/providers/ScanPharmacyQR';
  String pharmacyDetailsEndPoint =
      '${AppConstant.baseUrl}/api/app/patients/GetPharmacieById';

  String archivePharmacyEndPoint =
      '${AppConstant.baseUrl}/api/app/patients/UpdatePharmacyStatus';

  PharmaciesDataSourceImpl({required super.dio});

  @override
  Future<BaseResponse<Page<PharmacyModel>>> getPharmaciesList(
      GetPharmaciesListParamsModel paramsModel) async {
    final res = await get(
        url: getPharmaciesListEndPoint,
        decoder: (json) => Page.fromJson(
              json,
              PharmacyModel.fromJson,
              ListKeysPage.items,
            ),
        params: paramsModel.toJson(),
        requiredToken: true);

    return res;
  }

  @override
  Future<BaseResponse<Page<PharmacyModel>>> getArchivePharmaciesList(
      GetPharmaciesListParamsModel paramsModel) async {
    final res = await get(
        url: getArchivePharmaciesListEndPoint,
        decoder: (json) => Page.fromJson(
              json,
              PharmacyModel.fromJson,
              ListKeysPage.items,
            ),
        params: paramsModel.toJson(),
        requiredToken: true);

    return res;
  }

  @override
  Future<BaseResponse<PharmacyModel>> scanPharmacyQR(
      String providerCode) async {
    final res = await get(
        url: scanPharmacyQREndPoint,
        decoder: (json) => PharmacyModel.fromJson(json),
        params: {"providerCode": providerCode},
        requiredToken: true);

    return res;
  }

  @override
  Future<BaseResponse<PharmacyModel>> getPharmacyDetails(
      String pharmacyId) async {
    final res = await get(
        url: pharmacyDetailsEndPoint,
        decoder: (json) => PharmacyModel.fromJson(json),
        params: {"id": pharmacyId},
        requiredToken: true);
    return res;
  }

  @override
  Future<BaseResponse> archivePharmacy(String pharmacyId) async {
    final res = await get(
        url: archivePharmacyEndPoint,
        decoder: (json) => {},
        params: {"pharmacyId": pharmacyId},
        requiredToken: true);
    return res;
  }

  @override
  Future<BaseResponse<String>> addToMyPharmacy(String pharmacyId) async {
    final res = await post(
        url: addToMyPharmacyEndPoint,
        decoder: (json) => json.toString(),
        body: {"providerId": pharmacyId},
        requiredToken: true);
    return res;
  }
}
