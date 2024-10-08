part of 'authentication_cubit.dart';

@immutable
class AuthenticationState  extends Equatable{
  final AuthState authState;

  const AuthenticationState({required this.authState});

  AuthenticationState copyWith({AuthState? authState}) {
    return AuthenticationState(authState: authState ?? this.authState);
  }

  @override
  List<Object?> get props =>[authState.toString()];
}
