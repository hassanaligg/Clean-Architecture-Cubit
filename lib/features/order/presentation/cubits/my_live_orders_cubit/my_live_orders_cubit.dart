import 'package:bloc/bloc.dart';
import 'package:dawaa24/features/order/data/model/order_list_model.dart';
import 'package:dawaa24/features/order/domain/params/get_my_orders_params_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../core/data/model/base_response_model.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/failures/base_failure.dart';
import '../../../../../di/injection.dart';
import '../../../domain/usecase/get_my_latest_order_usecase.dart';

part 'my_live_orders_state.dart';

class MyLatestOrdersCubit extends Cubit<MyLatestOrdersState> {
  MyLatestOrdersCubit() : super(MyLatestOrdersState.initial()) {
    _getMyLatestUseCase = getIt<GetMyLatestUseCase>();
  }

  late GetMyLatestUseCase _getMyLatestUseCase;

  getLatestList({bool isRefresh = true}) async {
    if (isRefresh) {
      emit(state.createReLoadState());
    } else {
      emit(state.copyWith(status: MyLatestOrdersStatus.loadingMoreData));
    }
    try {
      emit(state.changeRequestModel());

      final Page<OrderListModel> res =
          (await _getMyLatestUseCase(state.getMyOrdersParamsModel!));
      if (isRefresh) {
        emit(state.copyWith(
            status: MyLatestOrdersStatus.success,
            myLiveOrdersListModel: res,
            skipCount: state.skipCount + state.maxResultCount!,
            refreshController: state.refreshController..refreshCompleted()));
      } else {
        emit(state.copyWith(
            status: MyLatestOrdersStatus.success,
            myLiveOrdersListModel: state.myLiveOrdersListModel!
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
              getMyLiveOrdersListFailure: l,
              status: MyLatestOrdersStatus.error,
              refreshController: state.refreshController..refreshFailed()),
        );
      } else {
        emit(
          state.copyWith(
              getMyLiveOrdersListFailure: l,
              status: MyLatestOrdersStatus.errorMoreData,
              refreshController: state.refreshController..loadFailed()),
        );
      }
    }
  }
}
