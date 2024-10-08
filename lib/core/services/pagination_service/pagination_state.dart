part of 'pagination_cubit.dart';

enum PaginationStatus {
  initial,
  refreshing,
  loading,
  error,
  //PaginationError
  loadMoreError,
  noDataFound,
  noDataToLoad,
  loadSuccess,
  refreshSuccess
}

class PaginationState<T> {
  final PaginationStatus status;
  final Failure? paginationFailure;
  final Page<T>? paginatedList;
  final RefreshController refreshController;
  final int currentPage;

  PaginationState._({
    required this.status,
    required this.paginationFailure,
    required this.paginatedList,
    required this.refreshController,
    required this.currentPage,
  });

  PaginationState.initial()
      : status = PaginationStatus.initial,
        paginationFailure = null,
        paginatedList = null,
        refreshController = RefreshController(initialRefresh: false),
        currentPage = 0;

  PaginationState paginationError(Failure failure) {
    return copyWith(
      status: PaginationStatus.error,
      paginationFailure: failure,
    );
  }

  PaginationState getListPaginationSuccess(Page<T> paginatedList,
      PaginationStatus status, int currentPage, bool isLoad) {
    Page<T> temp = Page(
        list: (isLoad)
            ? (this.paginatedList!.list..addAll(paginatedList.list))
            : paginatedList.list,
        count: (isLoad) ? this.paginatedList!.count : paginatedList.count);
    return copyWith(
        paginatedList: temp, status: status, currentPage: currentPage);
  }

  PaginationState changePageKey(int currentPage) {
    return copyWith(currentPage: currentPage);
  }

  copyWith(
      {PaginationStatus? status,
      Failure? paginationFailure,
      Page<T>? paginatedList,
      RefreshController? refreshController,
      int? currentPage}) {
    return PaginationState._(
      status: status ?? this.status,
      paginationFailure: paginationFailure ?? this.paginationFailure,
      paginatedList: paginatedList ?? this.paginatedList,
      refreshController: refreshController ?? this.refreshController,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  bool isShowList() {
    return status == PaginationStatus.loadSuccess ||
        status == PaginationStatus.refreshSuccess ||
        status == PaginationStatus.loading;
  }
}
