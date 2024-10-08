import 'package:dawaa24/core/presentation/widgets/loading_banner.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../services/pagination_service/pagination_cubit.dart';
import 'custom_empty_data.dart';
import 'error_panel.dart';
import 'loading_panel.dart';

class PaginatedList<T> extends StatelessWidget {
  const PaginatedList({
    required this.paginationCubit,
    required this.itemBuilder,
    this.separator,
    this.noData,
    this.padding,
    this.scrollDirection = Axis.vertical,
    this.isPaginated = true,
    Key? key,
  })  : _isGrid = false,
        gridDelegate = null,
        super(key: key);

  const PaginatedList.grid({
    required this.paginationCubit,
    required this.itemBuilder,
    this.gridDelegate,
    this.noData,
    this.padding,
    this.scrollDirection = Axis.vertical,
    this.isPaginated = true,
    Key? key,
  })  : _isGrid = true,
        separator = null,
        super(key: key);

  final PaginationCubit<T> paginationCubit;
  final Widget Function(T) itemBuilder;
  final EdgeInsetsGeometry? padding;
  final Widget? noData;
  final Axis scrollDirection;
  final bool isPaginated;

  /// for list only
  final Widget? separator;

  ///for grid only
  final bool _isGrid;
  final SliverGridDelegate? gridDelegate;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaginationCubit, PaginationState>(
      bloc: paginationCubit,
      listener: (context, state) {},
      builder: (context, state) {
        return SmartRefresher(
          controller: state.refreshController,
          enablePullUp: isPaginated,
          enablePullDown: true,
          scrollDirection: scrollDirection,
          onRefresh: () async {
            paginationCubit.load(false);
          },
          onLoading: () => paginationCubit.load(isPaginated),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus? mode) {
              Widget? body;
              if (mode == LoadStatus.noMore) {
                body = Text("failures.no_more_data".tr());
              }
              return SizedBox(
                child: Center(child: body ?? const SizedBox()),
              );
            },
          ),
          child: _buildContent(context, state),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, PaginationState state) {
    if (state.isShowList()) {
      if (_isGrid) {
        return GridView.builder(
          scrollDirection: scrollDirection,
          padding: padding,
          gridDelegate: gridDelegate ??
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
          itemCount: state.paginatedList!.list.length,
          itemBuilder: (_, index) =>
              itemBuilder(state.paginatedList!.list[index]),
        );
      }
      return ListView.separated(
        itemCount: state.paginatedList!.list.length,
        itemBuilder: (_, index) =>
            itemBuilder(state.paginatedList!.list[index]),
        separatorBuilder: (_, __) => separator ?? const SizedBox(),
        scrollDirection: scrollDirection,
        padding: padding,
      );
    }
    if (state.status == PaginationStatus.error) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: ErrorPanel(
          failure: state.paginationFailure!,
          onTryAgain: () {
            paginationCubit.load(false);
          },
        ),
      );
    }
    if (state.status == PaginationStatus.noDataFound) {
      return noData ?? const CustomEmptyData();
    }
    return (scrollDirection == Axis.vertical)
        ? const LoadingPanel()
        : const LoadingBanner();
  }
}
