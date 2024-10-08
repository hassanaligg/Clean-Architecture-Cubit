import 'package:bloc/bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../data/model/base_response_model.dart';
import '../../utils/failures/base_failure.dart';

part 'pagination_state.dart';

class PaginationCubit<T> extends Cubit<PaginationState> {
  final Future<Page<T>> Function(int currentPage, int maxResult) loadPage;

  PaginationCubit({required this.loadPage})
      : super(PaginationState<T>.initial()) {
    getPaginatedList(false);
  }

  getPaginatedList(bool getMore) async {
    try {
      final res = (await loadPage(state.currentPage, 14));
      if (res.list.isEmpty) {
        emit(state.copyWith(
          refreshController: state.refreshController
            ..refreshCompleted()
            ..loadNoData(),
        ));
        if (state.currentPage == 0) {
          emit(state.copyWith(status: PaginationStatus.noDataFound));
        }
      } else {
        emit(state.getListPaginationSuccess(
            res,
            (getMore)
                ? PaginationStatus.loadSuccess
                : PaginationStatus.refreshSuccess,
            state.currentPage + 14,
            getMore));
        (getMore)
            ? emit(state.copyWith(
                refreshController: state.refreshController..loadComplete()))
            : emit(state.copyWith(
                refreshController: state.refreshController
                  ..refreshCompleted()));
      }
    } on Failure catch (l) {
      if(getMore){
        emit(state.copyWith(
            refreshController: state.refreshController..loadFailed()));
      }
      else{
        emit(state.paginationError(l));
        emit(state.copyWith(
            refreshController: state.refreshController..refreshFailed()));
      }
    }
  }

  load(bool isLoad) {
    //reset the current page number
    if (!isLoad) {
      emit(state.changePageKey(0));
      emit(state.copyWith(
          refreshController: state.refreshController..resetNoData()));
    }
    //refresh page
    if (state.currentPage == 0) {
      emit(state.copyWith(status: PaginationStatus.refreshing));
      getPaginatedList(isLoad);
    } else {
      emit(state.copyWith(
        status: PaginationStatus.loading,
      ));
      getPaginatedList(isLoad);
    }
  }

  refresh() {
    state.refreshController.refreshCompleted();
    state.refreshController.resetNoData();
  }

  tryAgain() {
    emit(state.copyWith(status: PaginationStatus.initial));
    getPaginatedList(false);
  }
}
