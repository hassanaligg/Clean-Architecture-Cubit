import 'package:dawaa24/features/pharmacies/data/model/pharmacie_model.dart';
import 'package:dawaa24/features/pharmacies/domain/params/get_pharmacies_list_params.dart';

import '../../../../core/data/model/base_response_model.dart';

abstract class PharmaciesRepository {
  Future<Page<PharmacyModel>> getPharmaciesList(
      GetPharmaciesListParamsModel params);

  Future<Page<PharmacyModel>> getArchivePharmaciesList(
      GetPharmaciesListParamsModel params);

  Future<PharmacyModel> scanPharmacyQR(String providerCode);

  Future<PharmacyModel> getPharmacyDetails(String pharmacyId);

  Future<bool> archivePharmacy(String pharmacyId);

  Future<String> addToMyPharmacy(String pharmacyId);
}
