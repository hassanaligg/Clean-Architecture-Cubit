part of 'change_language_cubit.dart';

enum ChangeLanguageStatus {
  initial,
  loading,
  error,
  success,
}

class ChangeLanguageState {
  final ChangeLanguageStatus status;
  final Failure? failure;

  ChangeLanguageState._({
    required this.status,
    this.failure,
  });

  ChangeLanguageState.initial()
      : status = ChangeLanguageStatus.initial,
        failure = null;

  copyWith({ChangeLanguageStatus? status, Failure? failure}) {
    return ChangeLanguageState._(
        status: status ?? this.status, failure: failure ?? this.failure);
  }
}
