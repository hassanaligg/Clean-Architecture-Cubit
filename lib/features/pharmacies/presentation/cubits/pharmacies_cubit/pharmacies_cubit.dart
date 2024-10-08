import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../core/utils/failures/base_failure.dart';
import '../../../../../di/injection.dart';
import '../../../data/model/pharmacie_model.dart';
import '../../../domain/params/get_pharmacies_list_params.dart';
import '../../../domain/usecase/archive_pharmacy_usecase.dart';
import '../../../domain/usecase/get_archive_pharmacies_list_usecase.dart';
import '../../../domain/usecase/get_pharmacies_list_usecase.dart';

part 'pharmacies_state.dart';

class PharmaciesCubit extends Cubit<PharmaciesState> {
  PharmaciesCubit() : super(PharmaciesState.initial()) {
    _getPharmaciesListUseCase = getIt<GetPharmaciesListUseCase>();
    _getArchivePharmaciesListUseCase = getIt<GetArchivePharmaciesListUseCase>();
    _archivePharmaciesUseCase = getIt<ArchivePharmaciesUseCase>();
    getPharmaciesList();
    getArchivePharmaciesList();
  }

  late GetPharmaciesListUseCase _getPharmaciesListUseCase;
  late GetArchivePharmaciesListUseCase _getArchivePharmaciesListUseCase;
  late ArchivePharmaciesUseCase _archivePharmaciesUseCase;

  getPharmaciesList({bool isReload = true, bool isSearch = false}) async {
    if (isReload && !isSearch) {
      emit(state.createReLoadState());
    } else if (isReload && isSearch) {
      emit(state.createReLoadForSearchState());
    } else {
      emit(state.copyWith(status: PharmaciesStatus.loadingMoreData));
    }

    try {
      emit(state.changeRequestModel());
      var res = await _getPharmaciesListUseCase(state.params);

      if (isReload) {
        emit(state.copyWith(
            status: PharmaciesStatus.success,
            pharmacyListModel: res.list,
            skipCount: state.skipCount + 20,
            refreshController: state.refreshController..refreshCompleted()));
      } else {
        emit(state.copyWith(
            status: PharmaciesStatus.success,
            pharmacyListModel: state.pharmacyListModel..addAll(res.list),
            skipCount: state.skipCount + 20,
            refreshController: state.refreshController..loadComplete()));
      }
      if (res.list.isEmpty) {
        emit(state.copyWith(
            refreshController: state.refreshController..loadNoData()));
      }
    } on Failure catch (l) {
      if (isReload) {
        emit(
          state.copyWith(
              failure: l,
              status: PharmaciesStatus.error,
              refreshController: state.refreshController..refreshFailed()),
        );
      } else {
        emit(
          state.copyWith(
              failure: l,
              status: PharmaciesStatus.errorMoreData,
              refreshController: state.refreshController..loadFailed()),
        );
      }
    }
  }

  getArchivePharmaciesList(
      {bool isReload = true, bool isSearch = false}) async {
    print("hello");
    if (isReload && !isSearch) {
      emit(state.archiveCreateReLoadState());
    } else if (isReload && isSearch) {
      emit(state.archiveCreateReLoadForSearchState());
    } else {
      emit(state.copyWith(status: PharmaciesStatus.archiveLoadingMoreData));
    }

    try {
      emit(state.archiveChangeRequestModel());
      var res = await _getArchivePharmaciesListUseCase(state.archiveParams);

      if (isReload) {
        emit(state.copyWith(
            archiveStatus: PharmaciesStatus.archiveSuccess,
            archivePharmacyListModel: res.list,
            archiveSkipCount: state.skipCount + 20,
            refreshArchiveController: state.refreshArchiveController
              ..refreshCompleted()));
      } else {
        emit(state.copyWith(
            archiveStatus: PharmaciesStatus.archiveSuccess,
            archivePharmacyListModel: state.archivePharmacyListModel
              ..addAll(res.list),
            archiveSkipCount: state.archiveSkipCount + 20,
            refreshArchiveController: state.refreshArchiveController
              ..loadComplete()));
      }
      if (res.list.isEmpty) {
        emit(state.copyWith(
            refreshArchiveController: state.refreshArchiveController
              ..loadNoData()));
      }
    } on Failure catch (l) {
      if (isReload) {
        emit(
          state.copyWith(
              archiveFailure: l,
              archiveStatus: PharmaciesStatus.archiveError,
              refreshArchiveController: state.refreshArchiveController
                ..refreshFailed()),
        );
      } else {
        emit(
          state.copyWith(
              archiveFailure: l,
              archiveStatus: PharmaciesStatus.archiveErrorMoreData,
              refreshArchiveController: state.refreshArchiveController
                ..loadFailed()),
        );
      }
    }
  }

  changeOrderBy(PharmacySortingEnum order) {
    emit(state.copyWith(rate: order));
    getPharmaciesList();
  }

  archiveChangeOrderBy(PharmacySortingEnum order) {
    emit(state.copyWith(archiveRate: order));
    getArchivePharmaciesList();
  }

  changeSearchText(String str) {
    emit(state.copyWith(
        keyword: str, searchController: state.searchController..clear()));
  }

  archiveChangeSearchText(String str) {
    emit(state.copyWith(
        archiveKeyword: str,
        archiveSearchController: state.archiveSearchController..clear()));
  }

  archivePharmacy(String pharmacyId, {bool unArchive = false}) async {
    if (unArchive) {
      emit(state.copyWith(archiveStatus: PharmaciesStatus.archiveLoading));
    } else {
      emit(state.copyWith(status: PharmaciesStatus.loading));
    }
    try {
      await _archivePharmaciesUseCase(pharmacyId);
      emit(state.copyWith(status: PharmaciesStatus.archivePharmacySuccess));
    } on Failure catch (e) {
      if (unArchive) {
        emit(state.copyWith(failure: e, archiveStatus: PharmaciesStatus.archiveError));
      } else {
        emit(state.copyWith(failure: e, status: PharmaciesStatus.error));
      }
    }
  }

  refresh() async {
    await getPharmaciesList();
    await getArchivePharmaciesList();
  }
}
