import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/features/order/presentation/cubits/my_live_orders_cubit/my_live_orders_cubit.dart';
import 'package:dawaa24/features/order/presentation/widgets/order_list_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../core/presentation/resources/assets.gen.dart';
import '../../../../../core/presentation/widgets/error_panel.dart';
import '../../../../../core/presentation/widgets/loading_panel.dart';
import '../../../../../core/presentation/widgets/svg_icon.dart';

class MyLiveOrdersPage extends StatefulWidget {
  const MyLiveOrdersPage({super.key});

  @override
  State<MyLiveOrdersPage> createState() => _MyLiveOrdersPageState();
}

class _MyLiveOrdersPageState extends State<MyLiveOrdersPage> {
  late final MyLatestOrdersCubit myLiveOrdersCubit;

  @override
  void initState() {
    myLiveOrdersCubit = BlocProvider.of<MyLatestOrdersCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<MyLatestOrdersCubit, MyLatestOrdersState>(
            bloc: myLiveOrdersCubit,
            builder: (context, state) {
              return SmartRefresher(
                enablePullDown: true,
                enablePullUp: (state.status != MyLatestOrdersStatus.loading),
                header: const MaterialClassicHeader(),
                controller: state.refreshController,

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
                onRefresh: () {
                  myLiveOrdersCubit.getLatestList();
                },
                onLoading: () async {
                  myLiveOrdersCubit.getLatestList(isRefresh: false);
                },
                child: (state.status == MyLatestOrdersStatus.loading)
                    ? const LoadingPanel()
                    : (state.status == MyLatestOrdersStatus.error)
                        ? ErrorPanel(
                            failure: state.getMyLiveOrdersListFailure!,
                            onTryAgain: () => myLiveOrdersCubit.getLatestList(),
                          )
                        : ((state.myLiveOrdersListModel?.list ?? []).isNotEmpty)
                            ? ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 6),
                                itemCount:
                                    state.myLiveOrdersListModel!.list.length +
                                        1,
                                itemBuilder: (ctx, i) {
                                  if (i ==
                                      state
                                          .myLiveOrdersListModel!.list.length) {
                                    return SizedBox(
                                      height: MediaQuery.of(context)
                                              .padding
                                              .bottom +
                                          60.sp,
                                    );
                                  } else {
                                    return OrderListCardWidget(
                                      model:
                                          state.myLiveOrdersListModel!.list[i],
                                    );
                                  }
                                },
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.9,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3,
                                          child: CustomSvgIcon(
                                            Assets.images.noResultSearch,
                                            size: 0.80.sw,
                                            fit: BoxFit.contain,
                                          )),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Text(
                                        "my_orders.history_nothing_to_show"
                                            .tr(),
                                        style: context.textTheme.headlineMedium!
                                            .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 70.h,
                                      ),
                                    ],
                                  )
                                ],
                              ),
              );
            }));
  }
}
