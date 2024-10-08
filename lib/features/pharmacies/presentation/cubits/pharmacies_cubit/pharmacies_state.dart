part of 'pharmacies_cubit.dart';

enum PharmaciesStatus {
  initial,
  loading,
  archiveLoading,
  archivePharmacyLoading,
  archiveLoadingMoreData,
  loadingMoreData,
  error,
  archivePharmacyError,
  archiveError,
  archiveErrorMoreData,
  errorMoreData,
  success,
  archiveSuccess,
  archivePharmacySuccess,
}

class PharmaciesState {
  final RefreshController refreshController;
  final RefreshController refreshArchiveController;
  final PharmaciesStatus status;
  final PharmaciesStatus archiveStatus;
  final Failure? failure;
  final Failure? archiveFailure;
  final TextEditingController searchController;
  final TextEditingController archiveSearchController;
  final FocusNode focusNode;
  final FocusNode archiveFocusNode;
  final int skipCount;
  final int archiveSkipCount;
  final GetPharmaciesListParamsModel params;
  final GetPharmaciesListParamsModel archiveParams;
  final List<PharmacyModel> pharmacyListModel;
  final List<PharmacyModel> archivePharmacyListModel;
  final String keyword;
  final String archiveKeyword;
  final PharmacySortingEnum rate;
  final PharmacySortingEnum archiveRate;

  PharmaciesState._({
    required this.status,
    required this.archiveStatus,
    this.failure,
    this.archiveFailure,
    required this.pharmacyListModel,
    required this.archivePharmacyListModel,
    required this.params,
    required this.archiveParams,
    required this.rate,
    required this.archiveRate,
    required this.skipCount,
    required this.archiveSkipCount,
    required this.keyword,
    required this.archiveKeyword,
    required this.refreshController,
    required this.refreshArchiveController,
    required this.searchController,
    required this.archiveSearchController,
    required this.focusNode,
    required this.archiveFocusNode,
  });

  PharmaciesState.initial()
      : status = PharmaciesStatus.success,
        archiveStatus = PharmaciesStatus.success,
        refreshController = RefreshController(),
        refreshArchiveController = RefreshController(),
        rate = PharmacySortingEnum.addingDate_desc,
        archiveRate = PharmacySortingEnum.addingDate_desc,
        keyword = '',
        archiveKeyword = '',
        pharmacyListModel = [],
        archivePharmacyListModel = [],
        params = GetPharmaciesListParamsModel.empty(),
        archiveParams = GetPharmaciesListParamsModel.empty(),
        skipCount = 0,
        archiveSkipCount = 0,
        searchController = TextEditingController(),
        archiveSearchController = TextEditingController(),
        focusNode = FocusNode(),
        archiveFocusNode = FocusNode(),
        archiveFailure = null,
        failure = null;

  PharmaciesState createReLoadState() {
    return copyWith(
      status: PharmaciesStatus.loading,
      refreshController: refreshController
        ..refreshToIdle()
        ..loadComplete(),
      pharmacyListModel: null,
      failure: null,
      skipCount: 0,
    );
  }

  PharmaciesState archiveCreateReLoadState() {
    return copyWith(
      archiveStatus: PharmaciesStatus.archiveLoading,
      refreshArchiveController: refreshArchiveController
        ..refreshToIdle()
        ..loadComplete(),
      archivePharmacyListModel: null,
      archiveFailure: null,
      archiveSkipCount: 0,
    );
  }

  PharmaciesState createReLoadForSearchState() {
    return copyWith(
      status: PharmaciesStatus.loading,
      refreshController: refreshController
        ..refreshToIdle()
        ..loadComplete(),
      keyword: searchController.text,
      skipCount: 0,
      rate: rate,
    );
  }

  PharmaciesState archiveCreateReLoadForSearchState() {
    return copyWith(
      archiveStatus: PharmaciesStatus.archiveLoading,
      refreshArchiveController: refreshArchiveController
        ..refreshToIdle()
        ..loadComplete(),
      archiveKeyword: archiveSearchController.text,
      archiveSkipCount: 0,
      archiveRate: rate,
    );
  }

  PharmaciesState changeRequestModel() {
    return copyWith(
        params: params.copyWith(
            skipCount: skipCount,
            maxResultCount: 20,
            filterText: keyword,
            sorting: rate));
  }

  PharmaciesState archiveChangeRequestModel() {
    return copyWith(
        archiveParams: params.copyWith(
            skipCount: archiveSkipCount,
            maxResultCount: 20,
            filterText: archiveKeyword,
            sorting: archiveRate));
  }

  copyWith({
    PharmaciesStatus? status,
    PharmaciesStatus? archiveStatus,
    Failure? failure,
    Failure? archiveFailure,
    int? skipCount,
    int? archiveSkipCount,
    PharmacySortingEnum? rate,
    PharmacySortingEnum? archiveRate,
    GetPharmaciesListParamsModel? params,
    GetPharmaciesListParamsModel? archiveParams,
    String? keyword,
    String? archiveKeyword,
    TextEditingController? searchController,
    TextEditingController? archiveSearchController,
    RefreshController? refreshController,
    RefreshController? refreshArchiveController,
    List<PharmacyModel>? pharmacyListModel,
    List<PharmacyModel>? archivePharmacyListModel,
  }) {
    return PharmaciesState._(
      status: status ?? this.status,
      archiveStatus: archiveStatus ?? this.archiveStatus,
      refreshController: refreshController ?? this.refreshController,
      refreshArchiveController:
          refreshArchiveController ?? this.refreshArchiveController,
      focusNode: focusNode,
      archiveFocusNode: archiveFocusNode,
      rate: rate ?? this.rate,
      archiveRate: archiveRate ?? this.archiveRate,
      pharmacyListModel: pharmacyListModel ?? this.pharmacyListModel,
      archivePharmacyListModel:
          archivePharmacyListModel ?? this.archivePharmacyListModel,
      skipCount: skipCount ?? this.skipCount,
      archiveSkipCount: archiveSkipCount ?? this.archiveSkipCount,
      keyword: keyword ?? this.keyword,
      archiveKeyword: archiveKeyword ?? this.archiveKeyword,
      searchController: searchController ?? this.searchController,
      archiveSearchController:
          archiveSearchController ?? this.archiveSearchController,
      failure: failure ?? this.failure,
      archiveFailure: archiveFailure ?? this.archiveFailure,
      params: params ?? this.params,
      archiveParams: archiveParams ?? this.archiveParams,
    );
  }
}
