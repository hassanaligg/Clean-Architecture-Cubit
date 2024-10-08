import 'package:dawaa24/core/presentation/resources/theme/app_color.dart';
import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';
import 'package:dawaa24/core/presentation/widgets/error_panel.dart';
import 'package:dawaa24/core/presentation/widgets/loading_panel.dart';
import 'package:dawaa24/core/presentation/widgets/search_widget.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/features/pharmacies/domain/params/get_pharmacies_list_params.dart';
import 'package:dawaa24/features/pharmacies/presentation/widgets/pharmacy_list_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../cubits/pharmacies_cubit/pharmacies_cubit.dart';
import '../widgets/empty_widget.dart';

class ArchivePharmaciesPage extends StatefulWidget {
  const ArchivePharmaciesPage({super.key});

  @override
  State<ArchivePharmaciesPage> createState() => _ArchivePharmaciesPageState();
}

class _ArchivePharmaciesPageState extends State<ArchivePharmaciesPage> {
  late final PharmaciesCubit myPharmaciesCubit;
  late final ScrollController scrollController;

  @override
  void initState() {
    myPharmaciesCubit = BlocProvider.of<PharmaciesCubit>(context);
    scrollController = ScrollController();
    scrollController.addListener(() {
      myPharmaciesCubit.state.archiveFocusNode.unfocus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PharmaciesCubit, PharmaciesState>(
        bloc: myPharmaciesCubit,
        builder: (context, state) {
          return SmartRefresher(
            enablePullDown: true,
            enablePullUp:
                state.archiveStatus != PharmaciesStatus.archiveLoading,
            header: const MaterialClassicHeader(),
            controller: state.refreshArchiveController,
            scrollController: scrollController,
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
              state.archiveSearchController.clear();
              state.archiveFocusNode.unfocus();
              myPharmaciesCubit.archiveChangeSearchText('');
              myPharmaciesCubit.getArchivePharmaciesList();
            },
            onLoading: () async {
              myPharmaciesCubit.getArchivePharmaciesList(isReload: false);
            },
            child: (state.archiveStatus == PharmaciesStatus.archiveLoading)
                ? const LoadingPanel()
                : (state.archiveStatus == PharmaciesStatus.archiveError)
                    ? ErrorPanel(
                        failure: state.archiveFailure!,
                        onTryAgain: () =>
                            myPharmaciesCubit.getArchivePharmaciesList(),
                      )
                    : ((state.archivePharmacyListModel.isNotEmpty ))
                        ? SingleChildScrollView(
                            controller: scrollController,
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Column(
                                  children: [
                                    SizedBox(height: 16.h),
                                    SearchWidget(
                                      textEditingController:
                                          state.archiveSearchController,
                                      focusNode: state.archiveFocusNode,
                                      title: "my_pharmacies.search".tr(),
                                      onChange: (value) {
                                        setState(() {});
                                      },
                                      onFieldSubmitted: (value) {
                                        myPharmaciesCubit
                                            .getArchivePharmaciesList(
                                          isReload: true,
                                          isSearch: true,
                                        );
                                      },
                                      onCancel: () {
                                        state.archiveSearchController.clear();
                                        state.archiveFocusNode.unfocus();
                                        myPharmaciesCubit
                                            .archiveChangeSearchText('');
                                        myPharmaciesCubit
                                            .getArchivePharmaciesList();
                                      },
                                    ),
                                    SizedBox(height: 16.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Wrap(
                                          direction: Axis.vertical,
                                          children: [
                                            Text(
                                              'my_pharmacies.Sort_by'.tr(),
                                              style: context
                                                  .textTheme.headlineMedium,
                                            ),
                                          ],
                                        ),
                                        PopupMenuButton(
                                          color: Colors.white,
                                          surfaceTintColor: Colors.white,
                                          child: Row(
                                            children: [
                                              Text(
                                                (state.archiveRate ==
                                                        PharmacySortingEnum
                                                            .addingDate_desc)
                                                    ? "my_pharmacies.Newest to old"
                                                        .tr()
                                                    : "my_pharmacies.oldest to New"
                                                        .tr(),
                                                style: context
                                                    .textTheme.headlineMedium,
                                              ),
                                              SizedBox(
                                                width: 8.w,
                                              ),
                                              const Icon(
                                                Icons.keyboard_arrow_down,
                                                color: AppColors.black,
                                              )
                                            ],
                                          ),
                                          itemBuilder: (ctx) => [
                                            _optionMenuWidget(
                                                title:
                                                    "my_pharmacies.oldest to New"
                                                        .tr(),
                                                onTap: () {
                                                  myPharmaciesCubit
                                                      .archiveChangeOrderBy(
                                                          PharmacySortingEnum
                                                              .addingDate_asc);
                                                }),
                                            _optionMenuWidget(
                                                title:
                                                    "my_pharmacies.Newest to old"
                                                        .tr(),
                                                onTap: () {
                                                  myPharmaciesCubit
                                                      .archiveChangeOrderBy(
                                                          PharmacySortingEnum
                                                              .addingDate_desc);
                                                }),
                                          ],
                                        ),
                                      ],
                                    ),
                                    (state.archiveStatus ==
                                            PharmaciesStatus.archiveLoading)
                                        ? SizedBox(
                                            height: 1.sh / 1.7,
                                            child: const LoadingPanel())
                                        : (state.archiveStatus ==
                                                PharmaciesStatus.archiveError)
                                            ? SizedBox(
                                                height: 1.sh / 1.7,
                                                child: ErrorPanel(
                                                  failure:
                                                      state.archiveFailure!,
                                                  onTryAgain: () {
                                                    myPharmaciesCubit
                                                        .getArchivePharmaciesList();
                                                  },
                                                ))
                                            : SlidableAutoCloseBehavior(
                                                child: ListView.separated(
                                                  itemBuilder:
                                                      (context, index) =>
                                                          PharmacyListWidget(
                                                    pharmacyModel: state
                                                            .archivePharmacyListModel[
                                                        index],
                                                    onDismissed: () {},
                                                    isArchive: true,
                                                    onArchive: (context) async {
                                                      await myPharmaciesCubit
                                                          .archivePharmacy(
                                                              state
                                                                  .archivePharmacyListModel[
                                                                      index]
                                                                  .id,
                                                              unArchive: true);
                                                      myPharmaciesCubit
                                                          .refresh();
                                                    },
                                                  ),
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .only(start: 20.w),
                                                    child: Container(
                                                        height: 1,
                                                        color: AppMaterialColors
                                                            .grey.shade400),
                                                  ),
                                                  controller: scrollController,
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: state
                                                      .archivePharmacyListModel
                                                      .length,
                                                ),
                                              )
                                  ],
                                )),
                          )
                        : Column(
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              if (state.archiveSearchController.text.isNotEmpty)
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  child: SearchWidget(
                                    textEditingController:
                                        state.archiveSearchController,
                                    focusNode: state.archiveFocusNode,
                                    title: "my_pharmacies.search".tr(),
                                    onChange: (value) {},
                                    onFieldSubmitted: (value) {
                                      myPharmaciesCubit
                                          .getArchivePharmaciesList(
                                        isReload: true,
                                        isSearch: true,
                                      );
                                    },
                                    onCancel: () {
                                      state.archiveSearchController.clear();
                                      state.archiveFocusNode.unfocus();
                                      myPharmaciesCubit
                                          .archiveChangeSearchText('');
                                      myPharmaciesCubit
                                          .getArchivePharmaciesList();
                                    },
                                  ),
                                ),
                              if (state.archiveSearchController.text.isEmpty)
                                SizedBox(
                                  height: 0.1.sh,
                                ),
                              const EmptyWidget(),
                            ],
                          ),
          );
        },
      ),
    );
  }

  PopupMenuEntry _optionMenuWidget(
      {required String title, required Function() onTap}) {
    return PopupMenuItem(onTap: onTap, child: Text(title));
  }
}
