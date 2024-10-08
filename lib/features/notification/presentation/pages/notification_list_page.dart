import 'dart:ui';

import 'package:dawaa24/core/data/enums/notification_type_enum.dart';
import 'package:dawaa24/core/presentation/resources/assets.gen.dart';
import 'package:dawaa24/core/presentation/widgets/back_button.dart';
import 'package:dawaa24/core/presentation/widgets/error_panel.dart';
import 'package:dawaa24/core/presentation/widgets/loading_banner.dart';
import 'package:dawaa24/core/presentation/widgets/loading_panel.dart';
import 'package:dawaa24/core/presentation/widgets/svg_icon.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/core/utils/parse_helpers/failure_parser.dart';
import 'package:dawaa24/features/notification/presentation/cubits/my_notifications_cubit/dart/my_notifications_cubit.dart';
import 'package:dawaa24/features/notification/presentation/widgets/notification_card_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../main/presentation/cubits/main_page_cubit/main_page_cubit.dart';
import '../../../main/presentation/cubits/main_page_cubit/main_page_state.dart';
import '../cubits/mark_notification_as_read_cubit/mark_notification_as_read_cubit.dart';

class NotificationListPage extends StatefulWidget {
  const NotificationListPage({super.key});

  @override
  State<NotificationListPage> createState() => _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {
  late MyNotificationListCubit myNotificationListCubit;
  late MarkNotificationAsReadCubit markNotificationAsReadCubit;

  @override
  void initState() {
    super.initState();
    myNotificationListCubit = MyNotificationListCubit()..getLatestList();
    markNotificationAsReadCubit = MarkNotificationAsReadCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageCubit, MainPageState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                "notification.notifications_title".tr(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              // leading: const CustomBackButton(
              //   color: Colors.black,
              // ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: BlocBuilder<MyNotificationListCubit,
                          MyNotificationListState>(
                      bloc: myNotificationListCubit,
                      builder: (context, state) {
                        return BlocConsumer<MarkNotificationAsReadCubit,
                            MarkNotificationAsReadState>(
                          bloc: markNotificationAsReadCubit,
                          listener: (context, stateMarkNotification) {
                            if (stateMarkNotification.status ==
                                MarkNotificationAsReadStatus.error) {
                              FailureParser.mapFailureToString(
                                      failure: stateMarkNotification.failure!,
                                      context: context)
                                  .showToast();
                            }
                          },
                          builder: (context, stateMarkNotification) {
                            return SmartRefresher(
                              enablePullDown: true,
                              enablePullUp: (state.status !=
                                  MyNotificationListStatus.loading),
                              header: const MaterialClassicHeader(),
                              physics: stateMarkNotification.status ==
                                      MarkNotificationAsReadStatus.loading
                                  ? const NeverScrollableScrollPhysics()
                                  : const AlwaysScrollableScrollPhysics(),
                              controller: state.refreshController,
                              footer: CustomFooter(
                                builder:
                                    (BuildContext context, LoadStatus? mode) {
                                  Widget? body;
                                  if (mode == LoadStatus.noMore) {
                                    body = Text("failures.no_more_data".tr());
                                  }
                                  return SizedBox(
                                    child:
                                        Center(child: body ?? const SizedBox()),
                                  );
                                },
                              ),
                              onRefresh: () {
                                myNotificationListCubit.getLatestList();
                              },
                              onLoading: () async {
                                myNotificationListCubit.getLatestList(
                                    isRefresh: false);
                              },
                              child: (state.status ==
                                      MyNotificationListStatus.loading)
                                  ? const LoadingPanel()
                                  : (state.status ==
                                          MyNotificationListStatus.error)
                                      ? ErrorPanel(
                                          failure: state
                                              .getMyNotificationsListFailure!,
                                          onTryAgain: () =>
                                              myNotificationListCubit
                                                  .getLatestList(),
                                        )
                                      : ((state.notificationModelList?.list ??
                                                  [])
                                              .isNotEmpty)
                                          ? Stack(
                                              children: [
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 6,
                                                      vertical: 6),
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: state
                                                          .notificationModelList!
                                                          .list
                                                          .length +
                                                      1,
                                                  itemBuilder: (ctx, i) {
                                                    if (i ==
                                                        state
                                                            .notificationModelList!
                                                            .list
                                                            .length) {
                                                      return SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .padding
                                                                .bottom +
                                                            60.sp,
                                                      );
                                                    } else {
                                                      return InkWell(
                                                        onTap: () async {
                                                          bool result = false;
                                                          if (state
                                                                  .notificationModelList!
                                                                  .list[i]
                                                                  .isRead ??
                                                              false) {
                                                            result = true;
                                                          } else {
                                                            result = await markNotificationAsReadCubit
                                                                .markNotification(state
                                                                        .notificationModelList!
                                                                        .list[i]
                                                                        .id ??
                                                                    '');
                                                          }
                                                          if (result) {
                                                            routControllerNotificationTypeEnum(
                                                                state
                                                                        .notificationModelList!
                                                                        .list[i]
                                                                        .type ??
                                                                    NotificationTypeEnum
                                                                        .unKnown,
                                                                state
                                                                        .notificationModelList!
                                                                        .list[i]
                                                                        .entityId ??
                                                                    '-1',
                                                                state
                                                                        .notificationModelList!
                                                                        .list[i]
                                                                        .id ??
                                                                    '-1',
                                                                context);
                                                            state.notificationModelList!
                                                                    .list[i] =
                                                                state
                                                                    .notificationModelList!
                                                                    .list[i]
                                                                    .copyWith(
                                                                        isRead:
                                                                            true);
                                                          }
                                                        },
                                                        child:
                                                            NotificationCardWidget(
                                                          model: state
                                                              .notificationModelList!
                                                              .list[i],
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                                if (stateMarkNotification
                                                        .status ==
                                                    MarkNotificationAsReadStatus
                                                        .loading)
                                                  BackdropFilter(
                                                    filter: ImageFilter.blur(
                                                        sigmaX: 5.0,
                                                        sigmaY: 5.0),
                                                    child: Container(
                                                      color: Colors.black
                                                          .withOpacity(
                                                              0.5), // Semi-transparent background
                                                    ),
                                                  ),
                                                if (stateMarkNotification
                                                        .status ==
                                                    MarkNotificationAsReadStatus
                                                        .loading)
                                                  const Center(
                                                    child: LoadingBanner(),
                                                  ),
                                              ],
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.9,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            3,
                                                        child: CustomSvgIcon(
                                                          Assets.images
                                                              .noResultSearch,
                                                          size: 0.80.sw,
                                                          fit: BoxFit.contain,
                                                        )),
                                                    SizedBox(
                                                      height: 20.h,
                                                    ),
                                                    Text(
                                                      "notification.nothing_to_show"
                                                          .tr(),
                                                      style: context.textTheme
                                                          .headlineMedium!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    SizedBox(
                                                      height: 70.h,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                            );
                          },
                        );
                      }),
                ),
                SizedBox(
                  height: 20.h,
                )
              ],
            ));
      },
    );
  }
}
