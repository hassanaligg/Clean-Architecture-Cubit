part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}
class SplashLogedIn extends SplashState {}
class SplashLogedOut extends SplashState {}
class SplashNoConnection extends SplashState {}
