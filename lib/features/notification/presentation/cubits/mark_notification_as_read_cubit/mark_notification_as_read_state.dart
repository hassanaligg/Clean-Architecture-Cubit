part of 'mark_notification_as_read_cubit.dart';

enum MarkNotificationAsReadStatus { initial, loading, error, success }

class MarkNotificationAsReadState {
  final MarkNotificationAsReadStatus status;
  final Failure? failure;

  MarkNotificationAsReadState._(
      {required this.status, this.failure});

  MarkNotificationAsReadState.initial()
      : status = MarkNotificationAsReadStatus.initial,
        failure = null;

  copyWith(
      {MarkNotificationAsReadStatus? status,
      Failure? failure}) {
    return MarkNotificationAsReadState._(
      status: status ?? this.status,
      failure:
      failure ?? this.failure,
    );
  }
}
