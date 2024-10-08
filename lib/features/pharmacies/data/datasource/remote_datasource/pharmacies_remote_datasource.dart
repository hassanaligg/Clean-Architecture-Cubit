import 'package:dawaa24/features/pharmacies/domain/params/get_pharmacies_list_params.dart';

import '../../../../../core/data/model/base_response_model.dart';
import '../../model/pharmacie_model.dart';

abstract class PharmaciesRemoteDataSource {
  Future<BaseResponse<Page<PharmacyModel>>> getPharmaciesList(
      GetPharmaciesListParamsModel paramsModel);

  Future<BaseResponse<Page<PharmacyModel>>> getArchivePharmaciesList(
      GetPharmaciesListParamsModel paramsModel);

  Future<BaseResponse<PharmacyModel>> scanPharmacyQR(String providerCode);

  Future<BaseResponse<PharmacyModel>> getPharmacyDetails(String pharmacyId);

  Future<BaseResponse> archivePharmacy(String pharmacyId);

  Future<BaseResponse<String>> addToMyPharmacy(String pharmacyId);

}
