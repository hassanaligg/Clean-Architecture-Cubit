part of 'order_details_cubit.dart';

enum OrderDetailsStatus {
  initial,
  loading,
  error,
  success,
}

class OrderDetailsState {
  final OrderDetailsStatus status;
  final Failure? failure;
  final OrderDetailsModel? orderDetails;

  OrderDetailsState._({
    required this.status,
    this.failure,
    required this.orderDetails,
  });

  OrderDetailsState.initial()
      : status = OrderDetailsStatus.success,
        orderDetails = null,
        failure = null;

  copyWith({
    OrderDetailsStatus? status,
    OrderDetailsModel? orderDetails,
    Failure? failure,
  }) {
    return OrderDetailsState._(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      orderDetails: orderDetails ?? this.orderDetails,
    );
  }
}
