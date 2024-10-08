
import 'package:bloc/bloc.dart';
import 'package:dawaa24/features/order/data/model/order_list_model.dart';
import 'package:dawaa24/features/order/domain/usecase/get_my_historic_order_usecase.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../core/data/model/base_response_model.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/failures/base_failure.dart';
import '../../../../../di/injection.dart';
import '../../../domain/params/get_my_orders_params_model.dart';

part 'my_historic_orders_state.dart';

class MyHistoricOrdersCubit extends Cubit<MyHistoricOrdersState> {
  MyHistoricOrdersCubit() : super(MyHistoricOrdersState.initial()) {
    _getMyHistoricUseCase = getIt<GetMyHistoricUseCase>();
  }

  late GetMyHistoricUseCase _getMyHistoricUseCase;

  getHistoricList({bool isRefresh = true}) async {
    if (isRefresh) {
      emit(state.createReLoadState());
    } else {
      emit(state.copyWith(status: MyHistoricOrdersStatus.loadingMoreData));
    }
    try {
      emit(state.changeRequestModel());

      final Page<OrderListModel> res =
          (await _getMyHistoricUseCase(state.getMyOrdersParamsModel!));
      if (isRefresh) {
        emit(state.copyWith(
            status: MyHistoricOrdersStatus.success,
            myHistoricOrdersListModel: res,
            skipCount: state.skipCount + state.maxResultCount!,
            refreshController: state.refreshController..refreshCompleted()));
      } else {
        emit(state.copyWith(
            status: MyHistoricOrdersStatus.success,
            myHistoricOrdersListModel: state.myHistoricOrdersListModel!
              ..list.addAll(res.list),
            skipCount: state.skipCount + state.maxResultCount!,
            refreshController: state.refreshController..loadComplete()));
      }
      if (res.list.isEmpty) {
        emit(state.copyWith(
            refreshController: state.refreshController..loadNoData()));
      }
    } on Failure catch (l) {
      if (isRefresh) {
        emit(
          state.copyWith(
              getMyHistoricOrdersListFailure: l,
              status: MyHistoricOrdersStatus.error,
              refreshController: state.refreshController..refreshFailed()),
        );
      } else {
        emit(
          state.copyWith(
              getMyHistoricOrdersListFailure: l,
              status: MyHistoricOrdersStatus.errorMoreData,
              refreshController: state.refreshController..loadFailed()),
        );
      }
    }
  }
}
