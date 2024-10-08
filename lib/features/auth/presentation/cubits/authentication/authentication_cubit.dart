import 'package:bloc/bloc.dart';
import 'package:dawaa24/core/data/enums/auth_state.dart';
import 'package:dawaa24/core/utils/handler/auth_handler.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'authentication_state.dart';

@singleton
class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthHandler authHandler;

  AuthenticationCubit(this.authHandler)
      : super(const AuthenticationState(authState: AuthState.unKnown)) {
    authHandler.listen().listen(
      (event) {
        authStateChanges(event);
      },
    );
  }

  void authStateChanges(AuthState authState) {
    emit(AuthenticationState(authState: authState));
  }

  bool getAuthState() {
    return state.authState == AuthState.authenticated;
  }
}
