part of 'log_out_cubit.dart';

enum LogOutStatus {
  initial,
  loading,
  error,
  success,
}

class LogOutState {
  final LogOutStatus status;
  final Failure? failure;

  LogOutState._({
    required this.status,
    this.failure,
  });

  LogOutState.initial()
      : status = LogOutStatus.initial,
        failure = null;

  copyWith({LogOutStatus? status, Failure? failure}) {
    return LogOutState._(
        status: status ?? this.status, failure: failure ?? this.failure);
  }
}
