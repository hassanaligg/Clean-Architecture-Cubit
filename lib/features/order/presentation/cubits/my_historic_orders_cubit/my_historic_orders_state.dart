part of 'my_historic_orders_cubit.dart';

enum MyHistoricOrdersStatus {
  initial,
  loading,
  loadingMoreData,
  error,
  errorMoreData,
  noDataToGet, //on refresh success
  success
}

class MyHistoricOrdersState {
  final MyHistoricOrdersStatus status;
  final Failure? getMyHistoricOrdersListFailure;
  final Page<OrderListModel>? myHistoricOrdersListModel;
  final RefreshController refreshController;
  final GetMyOrdersParamsModel? getMyOrdersParamsModel;
  final int skipCount;
  final int? maxResultCount;

  MyHistoricOrdersState._({
    required this.status,
    this.getMyHistoricOrdersListFailure,
    this.getMyOrdersParamsModel,
    this.myHistoricOrdersListModel,
    required this.refreshController,
    this.maxResultCount = AppConstant.listMaxResult,
    this.skipCount = 0,
  });

  MyHistoricOrdersState.initial()
      : status = MyHistoricOrdersStatus.initial,
        getMyHistoricOrdersListFailure = null,
        myHistoricOrdersListModel = null,
        skipCount = 0,
        maxResultCount = AppConstant.listMaxResult,
        getMyOrdersParamsModel = GetMyOrdersParamsModel(),
        refreshController = RefreshController();

  MyHistoricOrdersState getRefillListError(Failure failure) {
    return copyWith(
      status: MyHistoricOrdersStatus.error,
      getMyHistoricOrdersListFailure: failure,
    );
  }

  MyHistoricOrdersState createReLoadState() {
    return copyWith(
      status: MyHistoricOrdersStatus.loading,
      refreshController: refreshController
        ..refreshToIdle()
        ..loadComplete(),
      myHistoricOrdersListModel: null,
      getMyHistoricOrdersListFailure: null,
      skipCount: 0,
    );
  }

  MyHistoricOrdersState changeRequestModel() {
    return copyWith(
        getMyOrdersParamsModel: GetMyOrdersParamsModel(
            skipCount: skipCount, maxResultCount: maxResultCount));
  }

  copyWith(
      {MyHistoricOrdersStatus? status,
      Failure? getMyHistoricOrdersListFailure,
      Page<OrderListModel>? myHistoricOrdersListModel,
      int? currentSlid,
      GetMyOrdersParamsModel? getMyOrdersParamsModel,
      int? skipCount,
      RefreshController? refreshController}) {
    return MyHistoricOrdersState._(
        status: status ?? this.status,
        getMyOrdersParamsModel:
            getMyOrdersParamsModel ?? this.getMyOrdersParamsModel,
        getMyHistoricOrdersListFailure: getMyHistoricOrdersListFailure ??
            this.getMyHistoricOrdersListFailure,
        myHistoricOrdersListModel:
            myHistoricOrdersListModel ?? this.myHistoricOrdersListModel,
        skipCount: skipCount ?? this.skipCount,
        refreshController: refreshController ?? this.refreshController);
  }
}
