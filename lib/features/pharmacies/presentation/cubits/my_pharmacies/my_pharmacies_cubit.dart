import 'package:bloc/bloc.dart';
import 'package:dawaa24/core/utils/failures/base_failure.dart';
import 'package:dawaa24/features/pharmacies/data/model/pharmacie_model.dart';
import 'package:dawaa24/features/pharmacies/domain/params/get_pharmacies_list_params.dart';
import 'package:dawaa24/features/pharmacies/domain/usecase/get_pharmacies_list_usecase.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../di/injection.dart';

part 'my_pharmacies_state.dart';

class MyPharmaciesCubit extends Cubit<MyPharmaciesState> {
  MyPharmaciesCubit() : super(MyPharmaciesState.initial()) {
    _getPharmaciesListUseCase = getIt<GetPharmaciesListUseCase>();
    getPharmaciesList();
  }

  changeSearchText(String str) {
    emit(state.copyWith(
        keyword: str, searchController: state.searchController..clear()));
  }

  late GetPharmaciesListUseCase _getPharmaciesListUseCase;

  changeOrderBy(PharmacySortingEnum order) {
    emit(state.copyWith(rate: order));
    getPharmaciesList();
  }

  getPharmaciesList({bool isReload = true, bool isSearch = false}) async {
    if (isReload && !isSearch) {
      emit(state.createReLoadState());
    } else if (isReload && isSearch) {
      emit(state.createReLoadForSearchState());
    } else {
      emit(state.copyWith(status: MyPharmaciesStatus.loadingMoreData));
    }

    try {
      emit(state.changeRequestModel());
      var res = await _getPharmaciesListUseCase(state.params);

      if (isReload) {
        emit(state.copyWith(
            status: MyPharmaciesStatus.success,
            pharmacyListModel: res.list,
            skipCount: state.skipCount + 20,
            refreshController: state.refreshController..refreshCompleted()));
      } else {
        emit(state.copyWith(
            status: MyPharmaciesStatus.success,
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
              status: MyPharmaciesStatus.error,
              refreshController: state.refreshController..refreshFailed()),
        );
      } else {
        emit(
          state.copyWith(
              failure: l,
              status: MyPharmaciesStatus.errorMoreData,
              refreshController: state.refreshController..loadFailed()),
        );
      }
    }
  }
}
