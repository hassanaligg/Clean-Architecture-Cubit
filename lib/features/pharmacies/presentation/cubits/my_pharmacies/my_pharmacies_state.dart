part of 'my_pharmacies_cubit.dart';

enum MyPharmaciesStatus {
  initial,
  loading,
  loadingMoreData,
  error,
  errorMoreData,
  success,
}

class MyPharmaciesState {
  final RefreshController refreshController;
  final MyPharmaciesStatus status;
  final Failure? failure;
  final TextEditingController searchController;
  final FocusNode focusNode;
  final int skipCount;
  final GetPharmaciesListParamsModel params;
  final List<PharmacyModel> pharmacyListModel;
  final String keyword;
  final PharmacySortingEnum rate;

  MyPharmaciesState._(
      {required this.status,
      this.failure,
      required this.pharmacyListModel,
      required this.params,
      required this.rate,
      required this.skipCount,
      required this.keyword,
      required this.refreshController,
      required this.searchController,
      required this.focusNode});

  MyPharmaciesState.initial()
      : status = MyPharmaciesStatus.success,
        refreshController = RefreshController(),
        rate = PharmacySortingEnum.addingDate_desc,
        keyword = '',
        pharmacyListModel = [],
        params = GetPharmaciesListParamsModel.empty(),
        skipCount = 0,
        searchController = TextEditingController(),
        focusNode = FocusNode(),
        failure = null;

  MyPharmaciesState createReLoadState() {
    return copyWith(
      status: MyPharmaciesStatus.loading,
      refreshController: refreshController
        ..refreshToIdle()
        ..loadComplete(),
      skipCount: 0,
      keyword: '',
      rate: rate,
    );
  }

  MyPharmaciesState createReLoadForSearchState() {
    return copyWith(
      status: MyPharmaciesStatus.loading,
      refreshController: refreshController
        ..refreshToIdle()
        ..loadComplete(),
      keyword: searchController.text,
      skipCount: 0,
      rate: rate,
    );
  }

  MyPharmaciesState changeRequestModel() {
    return copyWith(
        params: params.copyWith(
            skipCount: skipCount,
            maxResultCount: 20,
            filterText: keyword,
            sorting: rate));
  }

  copyWith(
      {MyPharmaciesStatus? status,
      Failure? failure,
      int? skipCount,
      PharmacySortingEnum? rate,
      GetPharmaciesListParamsModel? params,
      String? keyword,
      TextEditingController? searchController,
      RefreshController? refreshController,
      List<PharmacyModel>? pharmacyListModel}) {
    return MyPharmaciesState._(
      status: status ?? this.status,
      refreshController: refreshController ?? this.refreshController,
      focusNode: focusNode,
      rate: rate ?? this.rate,
      pharmacyListModel: pharmacyListModel ?? this.pharmacyListModel,
      skipCount: skipCount ?? this.skipCount,
      keyword: keyword ?? this.keyword,
      searchController: searchController ?? this.searchController,
      failure: failure ?? this.failure,
      params: params ?? this.params,
    );
  }
}
