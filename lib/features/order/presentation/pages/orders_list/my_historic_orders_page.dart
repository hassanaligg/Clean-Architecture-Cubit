import 'package:dawaa24/core/presentation/resources/assets.gen.dart';
import 'package:dawaa24/core/presentation/widgets/error_panel.dart';
import 'package:dawaa24/core/presentation/widgets/loading_panel.dart';
import 'package:dawaa24/core/presentation/widgets/svg_icon.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../cubits/my_historic_orders_cubit/my_historic_orders_cubit.dart';
import '../../widgets/order_list_widget.dart';

class MyHistoricOrdersPage extends StatefulWidget {
  const MyHistoricOrdersPage({super.key});

  @override
  State<MyHistoricOrdersPage> createState() => _MyHistoricOrdersPageState();
}

class _MyHistoricOrdersPageState extends State<MyHistoricOrdersPage> {
  late final MyHistoricOrdersCubit myHistoricOrdersCubit;

  @override
  void initState() {
    myHistoricOrdersCubit = BlocProvider.of<MyHistoricOrdersCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<MyHistoricOrdersCubit, MyHistoricOrdersState>(
            bloc: myHistoricOrdersCubit,
            builder: (context, state) {
              return SmartRefresher(
                enablePullDown: true,
                enablePullUp: (state.status != MyHistoricOrdersStatus.loading),
                header: const MaterialClassicHeader(),
                controller: state.refreshController,
                footer: CustomFooter( builder: (BuildContext context, LoadStatus? mode) { Widget? body; if (mode == LoadStatus.noMore) { body = Text("failures.no_more_data".tr()); } return SizedBox( child: Center(child: body ?? const SizedBox()), ); }, ),
                onRefresh: () {
                  myHistoricOrdersCubit.getHistoricList();
                },
                onLoading: () async {
                  myHistoricOrdersCubit.getHistoricList(isRefresh: false);
                },
                child: (state.status == MyHistoricOrdersStatus.loading)
                    ? const LoadingPanel()
                    : (state.status == MyHistoricOrdersStatus.error)
                        ? ErrorPanel(
                            failure: state.getMyHistoricOrdersListFailure!,
                            onTryAgain: () =>
                                myHistoricOrdersCubit.getHistoricList(),
                          )
                        : ((state.myHistoricOrdersListModel?.list ?? [])
                                .isNotEmpty)
                            ? ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 6),
                                itemCount: state.myHistoricOrdersListModel!.list
                                        .length +
                                    1,
                                itemBuilder: (ctx, i) {
                                  if (i ==
                                      state.myHistoricOrdersListModel!.list
                                          .length) {
                                    return SizedBox(
                                      height: MediaQuery.of(context)
                                              .padding
                                              .bottom +
                                          60.sp,
                                    );
                                  } else {
                                    return OrderListCardWidget(
                                      model: state
                                          .myHistoricOrdersListModel!.list[i],
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
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.9,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        child: CustomSvgIcon(
                                          Assets.images.noResultSearch,
                                          size:0.80.sw,
                                          fit: BoxFit.contain,
                                        )
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Text(
                                        "my_orders.history_nothing_to_show".tr(),
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
