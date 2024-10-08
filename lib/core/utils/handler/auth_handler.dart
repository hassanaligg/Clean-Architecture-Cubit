import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../data/enums/auth_state.dart';


@singleton
class AuthHandler {
  final StreamController<AuthState> _authStream;

  AuthHandler() : _authStream = StreamController();

  Stream<AuthState> listen() {
    return _authStream.stream;
  }

  void changeAuthState(AuthState newState) {
    _authStream.add(newState);
  }
}
