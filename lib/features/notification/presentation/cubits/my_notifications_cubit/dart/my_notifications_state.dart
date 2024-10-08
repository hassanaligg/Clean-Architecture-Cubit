
part of 'my_notifications_cubit.dart';

enum MyNotificationListStatus {
  initial,
  loading,
  loadingMoreData,
  error,
  errorMoreData,
  noDataToGet, //on refresh success
  success
}

class MyNotificationListState {
  final MyNotificationListStatus status;
  final Failure? getMyNotificationsListFailure;
  final Page<NotificationModel>? notificationModelList;
  final RefreshController refreshController;
  final GetMyOrdersParamsModel? getMyOrdersParamsModel;
  final int skipCount;
  final int? maxResultCount;

  MyNotificationListState._({
    required this.status,
    this.getMyNotificationsListFailure,
    this.getMyOrdersParamsModel,
    this.notificationModelList,
    required this.refreshController,
    this.maxResultCount = AppConstant.listMaxResult,
    this.skipCount = 0,
  });

  MyNotificationListState.initial()
      : status = MyNotificationListStatus.initial,
        getMyNotificationsListFailure = null,
        notificationModelList = null,
        skipCount = 0,
        maxResultCount = AppConstant.listMaxResult,
        getMyOrdersParamsModel = GetMyOrdersParamsModel(),
        refreshController = RefreshController();

  MyNotificationListState getRefillListError(Failure failure) {
    return copyWith(
      status: MyNotificationListStatus.error,
      getMyLiveOrdersListFailure: failure,
    );
  }

  MyNotificationListState createReLoadState() {
    return copyWith(
      status: MyNotificationListStatus.loading,
      refreshController: refreshController
        ..refreshToIdle()
        ..loadComplete(),
      notificationModelList: null,
      getMyLiveOrdersListFailure: null,
      skipCount: 0,
    );
  }

  MyNotificationListState changeRequestModel() {
    return copyWith(
        getMyOrdersParamsModel: GetMyOrdersParamsModel(
            skipCount: skipCount, maxResultCount: maxResultCount));
  }

  copyWith(
      {MyNotificationListStatus? status,
      Failure? getMyLiveOrdersListFailure,
      Page<NotificationModel>? notificationModelList,
      int? currentSlid,
      GetMyOrdersParamsModel? getMyOrdersParamsModel,
      int? skipCount,
      RefreshController? refreshController}) {
    return MyNotificationListState._(
        status: status ?? this.status,
        getMyOrdersParamsModel:
            getMyOrdersParamsModel ?? this.getMyOrdersParamsModel,
        getMyNotificationsListFailure:
            getMyLiveOrdersListFailure ?? this.getMyNotificationsListFailure,
        notificationModelList:
            notificationModelList ?? this.notificationModelList,
        skipCount: skipCount ?? this.skipCount,
        refreshController: refreshController ?? this.refreshController);
  }
}
