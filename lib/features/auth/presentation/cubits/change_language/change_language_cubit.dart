import 'package:bloc/bloc.dart';
import 'package:dawaa24/features/auth/domain/usecase/change_language_usecase.dart';

import '../../../../../core/utils/failures/base_failure.dart';
import '../../../../../di/injection.dart';

part 'change_language_state.dart';

class ChangeLanguageCubit extends Cubit<ChangeLanguageState> {
  ChangeLanguageCubit() : super(ChangeLanguageState.initial()) {
    _changeLanguageUseCase = getIt<ChangeLanguageUseCase>();
  }

  late ChangeLanguageUseCase _changeLanguageUseCase;

  Future<bool> changeLanguage({required bool isArabic}) async {
    {
      try {
        emit(state.copyWith(status: ChangeLanguageStatus.loading));
        await _changeLanguageUseCase.call(isArabic);
        emit(state.copyWith(status: ChangeLanguageStatus.success));
        return true;
      } on Failure catch (l) {
        emit(state.copyWith(status: ChangeLanguageStatus.error, failure: l));
        return false;
      }
    }
  }
}
