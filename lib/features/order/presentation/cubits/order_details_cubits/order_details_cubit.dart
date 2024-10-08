import 'package:bloc/bloc.dart';
import 'package:dawaa24/core/utils/failures/base_failure.dart';
import 'package:dawaa24/features/order/data/model/order_details_model.dart';

import '../../../../../di/injection.dart';
import '../../../domain/usecase/get_order_details_usecase.dart';

part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit() : super(OrderDetailsState.initial()) {
    _getOrderDetailsUseCase = getIt<GetOrderDetailsUseCase>();
  }

  late GetOrderDetailsUseCase _getOrderDetailsUseCase;

  getOrderDetails(String orderId) async {
    emit(state.copyWith(status: OrderDetailsStatus.loading));
    try {
      var orderDetails = await _getOrderDetailsUseCase(orderId);
      emit(state.copyWith(
          status: OrderDetailsStatus.success, orderDetails: orderDetails));
    } on Failure catch (e) {
      emit(state.copyWith(failure: e, status: OrderDetailsStatus.error));
    }
  }
}
