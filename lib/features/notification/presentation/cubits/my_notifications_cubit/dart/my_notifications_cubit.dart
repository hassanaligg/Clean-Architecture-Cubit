import 'package:bloc/bloc.dart';
import 'package:dawaa24/core/data/model/base_response_model.dart';
import 'package:dawaa24/core/utils/constants.dart';
import 'package:dawaa24/core/utils/failures/base_failure.dart';
import 'package:dawaa24/features/notification/data/model/notification_model.dart';
import 'package:dawaa24/features/notification/domain/usecase/get_my_notifications_list_usecase.dart';
import 'package:dawaa24/features/order/domain/params/get_my_orders_params_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../../di/injection.dart';

part 'my_notifications_state.dart';
class MyNotificationListCubit extends Cubit<MyNotificationListState> {
  MyNotificationListCubit() : super(MyNotificationListState.initial()) {
    _getMyNotificationListUseCase = getIt<GetMyNotificationListUseCase>();
  }

  late GetMyNotificationListUseCase _getMyNotificationListUseCase;

  getLatestList({bool isRefresh = true}) async {
    if (isRefresh) {
      emit(state.createReLoadState());
    } else {
      emit(state.copyWith(status: MyNotificationListStatus.loadingMoreData));
    }
    try {
      emit(state.changeRequestModel());

      final Page<NotificationModel> res =
          (await _getMyNotificationListUseCase(state.getMyOrdersParamsModel!));
      if (isRefresh) {
        emit(state.copyWith(
            status: MyNotificationListStatus.success,
            notificationModelList: res,
            skipCount: state.skipCount + state.maxResultCount!,
            refreshController: state.refreshController..refreshCompleted()));
      } else {
        emit(state.copyWith(
            status: MyNotificationListStatus.success,
            notificationModelList: state.notificationModelList!
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
              status: MyNotificationListStatus.error,
              refreshController: state.refreshController..refreshFailed()),
        );
      } else {
        emit(
          state.copyWith(
              getMyLiveOrdersListFailure: l,
              status: MyNotificationListStatus.errorMoreData,
              refreshController: state.refreshController..loadFailed()),
        );
      }
    }
  }
}
