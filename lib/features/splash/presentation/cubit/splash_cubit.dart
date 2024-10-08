import 'package:bloc/bloc.dart';
import 'package:dawaa24/core/utils/failures/base_failure.dart';
import 'package:dawaa24/di/injection.dart';
import 'package:dawaa24/features/auth/domain/repository/auth_repository.dart';
import 'package:meta/meta.dart';

import '../../../../core/utils/failures/http/http_failure.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void startCounter() async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      (await getIt<AuthRepository>().checkToken());
      emit(SplashLogedIn());
    } on Failure catch (l) {
      if (l is NoInternetFailure) {
        emit(SplashNoConnection());
        return;
      }
      emit(SplashLogedOut());
    }
  }

  void retry() async {
    emit(SplashInitial());
    await Future.delayed(const Duration(seconds: 3));

    try {
      (await getIt<AuthRepository>().checkToken());
      emit(SplashLogedIn());
    } on Failure catch (l) {
      if (l is NoInternetFailure) {
        emit(SplashNoConnection());
        return;
      }
      emit(SplashLogedOut());
    }
  }
}
