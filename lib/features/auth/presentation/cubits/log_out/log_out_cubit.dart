import 'package:bloc/bloc.dart';
import 'package:dawaa24/core/domain/usecase/usecase.dart';
import 'package:dawaa24/features/auth/domain/usecase/logout_usecase.dart';

import '../../../../../core/services/agora_service.dart';
import '../../../../../core/utils/failures/base_failure.dart';
import '../../../../../di/injection.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit() : super(LogOutState.initial()) {
    logOutUseCase = getIt<LogOutUseCase>();
    _agoraService = getIt<AgoraService>();
  }

  late LogOutUseCase logOutUseCase;
  late AgoraService _agoraService;

  void logOut() async {
    {
      try {
        emit(state.copyWith(status: LogOutStatus.loading));
        await logOutUseCase.call(NoParams());
        _agoraService.signOut();
        emit(state.copyWith(status: LogOutStatus.success));
      } on Failure catch (l) {
        emit(state.copyWith(status: LogOutStatus.error, failure: l));
      }
    }
  }
}
