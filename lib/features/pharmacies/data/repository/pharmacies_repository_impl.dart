import 'package:dawaa24/core/data/model/base_response_model.dart';
import 'package:dawaa24/features/pharmacies/data/datasource/remote_datasource/pharmacies_remote_datasource.dart';
import 'package:dawaa24/features/pharmacies/data/model/pharmacie_model.dart';
import 'package:dawaa24/features/pharmacies/domain/params/get_pharmacies_list_params.dart';
import 'package:dawaa24/features/pharmacies/domain/repository/pharmacy_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: PharmaciesRepository)
class PharmaciesRepositoryImpl implements PharmaciesRepository {
  final PharmaciesRemoteDataSource remoteDataSource;

  PharmaciesRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<Page<PharmacyModel>> getPharmaciesList(
      GetPharmaciesListParamsModel params) async {
    final res = await remoteDataSource.getPharmaciesList(params);
    return res.data!;
  }

  @override
  Future<Page<PharmacyModel>> getArchivePharmaciesList(
      GetPharmaciesListParamsModel params) async {
    final res = await remoteDataSource.getArchivePharmaciesList(params);
    return res.data!;
  }

  @override
  Future<PharmacyModel> scanPharmacyQR(String providerCode) async {
    final res = await remoteDataSource.scanPharmacyQR(providerCode);
    return res.data!;
  }

  @override
  Future<PharmacyModel> getPharmacyDetails(String pharmacyId) async {
    final res = await remoteDataSource.getPharmacyDetails(pharmacyId);
    return res.data!;
  }

  @override
  Future<bool> archivePharmacy(String pharmacyId) async {
    final res = await remoteDataSource.archivePharmacy(pharmacyId);
    return true;
  }

  @override
  Future<String> addToMyPharmacy(String pharmacyId) async {
    final res = await remoteDataSource.addToMyPharmacy(pharmacyId);
    return res.data!;
  }
}
