import 'package:dawaa24/core/domain/usecase/usecase.dart';
import 'package:dawaa24/features/pharmacies/data/model/pharmacie_model.dart';
import 'package:dawaa24/features/pharmacies/domain/params/get_pharmacies_list_params.dart';
import 'package:dawaa24/features/pharmacies/domain/repository/pharmacy_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/model/base_response_model.dart';

@injectable
class GetPharmaciesListUseCase
    extends UseCase<Page<PharmacyModel>, GetPharmaciesListParamsModel> {
  final PharmaciesRepository repository;

  GetPharmaciesListUseCase({required this.repository});

  @override
  Future<Page<PharmacyModel>> call(params) async {
    return repository.getPharmaciesList(params);
  }
}
