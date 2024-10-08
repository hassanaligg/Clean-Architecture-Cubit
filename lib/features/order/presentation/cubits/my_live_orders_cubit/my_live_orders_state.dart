part of 'my_live_orders_cubit.dart';

enum MyLatestOrdersStatus {
  initial,
  loading,
  loadingMoreData,
  error,
  errorMoreData,
  noDataToGet, //on refresh success
  success
}

class MyLatestOrdersState {
  final MyLatestOrdersStatus status;
  final Failure? getMyLiveOrdersListFailure;
  final Page<OrderListModel>? myLiveOrdersListModel;
  final RefreshController refreshController;
  final GetMyOrdersParamsModel? getMyOrdersParamsModel;
  final int skipCount;
  final int? maxResultCount;

  MyLatestOrdersState._({
    required this.status,
    this.getMyLiveOrdersListFailure,
    this.getMyOrdersParamsModel,
    this.myLiveOrdersListModel,
    required this.refreshController,
    this.maxResultCount = AppConstant.listMaxResult,
    this.skipCount = 0,
  });

  MyLatestOrdersState.initial()
      : status = MyLatestOrdersStatus.initial,
        getMyLiveOrdersListFailure = null,
        myLiveOrdersListModel = null,
        skipCount = 0,
        maxResultCount = AppConstant.listMaxResult,
        getMyOrdersParamsModel = GetMyOrdersParamsModel(),
        refreshController = RefreshController();

  MyLatestOrdersState getRefillListError(Failure failure) {
    return copyWith(
      status: MyLatestOrdersStatus.error,
      getMyLiveOrdersListFailure: failure,
    );
  }

  MyLatestOrdersState createReLoadState() {
    return copyWith(
      status: MyLatestOrdersStatus.loading,
      refreshController: refreshController
        ..refreshToIdle()
        ..loadComplete(),
      myLiveOrdersListModel: null,
      getMyLiveOrdersListFailure: null,
      skipCount: 0,
    );
  }

  MyLatestOrdersState changeRequestModel() {
    return copyWith(
        getMyOrdersParamsModel: GetMyOrdersParamsModel(
            skipCount: skipCount, maxResultCount: maxResultCount));
  }

  copyWith(
      {MyLatestOrdersStatus? status,
      Failure? getMyLiveOrdersListFailure,
      Page<OrderListModel>? myLiveOrdersListModel,
      int? currentSlid,
      GetMyOrdersParamsModel? getMyOrdersParamsModel,
      int? skipCount,
      RefreshController? refreshController}) {
    return MyLatestOrdersState._(
        status: status ?? this.status,
        getMyOrdersParamsModel:
            getMyOrdersParamsModel ?? this.getMyOrdersParamsModel,
        getMyLiveOrdersListFailure:
            getMyLiveOrdersListFailure ?? this.getMyLiveOrdersListFailure,
        myLiveOrdersListModel:
            myLiveOrdersListModel ?? this.myLiveOrdersListModel,
        skipCount: skipCount ?? this.skipCount,
        refreshController: refreshController ?? this.refreshController);
  }
}
