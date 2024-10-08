import 'package:bloc/bloc.dart';
import 'package:dawaa24/features/address/domain/usecase/get_address_usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/domain/usecase/usecase.dart';
import '../../../../../core/services/location_helper.dart';
import '../../../../../core/utils/failures/base_failure.dart';
import '../../../../../di/injection.dart';
import '../../../../auth/data/model/profile_model.dart';
import '../../../../auth/domain/usecase/get_user_info_usecase.dart';
import 'main_page_state.dart';

@singleton
class MainPageCubit extends Cubit<MainPageState> {
  late LocationHelper locationHelper;

  MainPageCubit() : super(MainPageState.initial()) {
    _getUserInfoUseCase = getIt<GetUserInfoUseCase>();
    // getUserInfo();
  }

  late GetUserInfoUseCase _getUserInfoUseCase;

  getUserInfo() async {
    emit(state.copyWith(status: MainPageStatus.loading));

    try {
      ProfileModel profile = await _getUserInfoUseCase(NoParams());
      emit(state.copyWith(
        status: MainPageStatus.success,
        profileModel: profile,
      ));
    } on Failure catch (l) {
      emit(state.copyWith(mainPageFailure: l, status: MainPageStatus.error));
    }
  }

  refreshPage() {
    emit(state.copyWith(status: MainPageStatus.refresh));
    emit(state.copyWith(status: MainPageStatus.success));
  }
}
