import 'package:dawaa24/core/domain/usecase/usecase.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/country_model.dart';
import '../repository/auth_repository.dart';

@injectable
class GetCountriesUseCase extends UseCase<List<CountryModel>, NoParams> {
  final AuthRepository repository;

  GetCountriesUseCase(this.repository);

  @override
  Future<List<CountryModel>> call(NoParams params) async {
    return await repository.getCountries();
  }
}
