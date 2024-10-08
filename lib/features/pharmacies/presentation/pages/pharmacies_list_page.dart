import 'package:dawaa24/core/presentation/resources/assets.gen.dart';
import 'package:dawaa24/core/presentation/resources/theme/app_color.dart';
import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';
import 'package:dawaa24/core/presentation/widgets/custom_container.dart';
import 'package:dawaa24/core/presentation/widgets/error_panel.dart';
import 'package:dawaa24/core/presentation/widgets/loading_panel.dart';
import 'package:dawaa24/core/presentation/widgets/search_widget.dart';
import 'package:dawaa24/core/presentation/widgets/svg_icon.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/features/pharmacies/domain/params/get_pharmacies_list_params.dart';
import 'package:dawaa24/features/pharmacies/presentation/widgets/pharmacy_list_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/presentation/resources/theme/app_gradients.dart';
import '../../../../router.dart';
import '../cubits/pharmacies_cubit/pharmacies_cubit.dart';
import '../widgets/empty_widget.dart';

class PharmaciesListPage extends StatefulWidget {
  const PharmaciesListPage({super.key});

  @override
  State<PharmaciesListPage> createState() => _PharmaciesListPageState();
}

class _PharmaciesListPageState extends State<PharmaciesListPage> {
  late final PharmaciesCubit myPharmaciesCubit;
  late final ScrollController scrollController;

  @override
  void initState() {
    myPharmaciesCubit = BlocProvider.of<PharmaciesCubit>(context);
    scrollController = ScrollController();
    scrollController.addListener(() {
      myPharmaciesCubit.state.focusNode.unfocus();
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
              enablePullUp: state.status != PharmaciesStatus.loading,
              header: const MaterialClassicHeader(),
              controller: state.refreshController,
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
                state.searchController.clear();
                state.focusNode.unfocus();
                myPharmaciesCubit.changeSearchText('');
                myPharmaciesCubit.getPharmaciesList();
              },
              onLoading: () async {
                myPharmaciesCubit.getPharmaciesList(isReload: false);
              },
              child: (state.status == PharmaciesStatus.loading)
                  ? const LoadingPanel()
                  : (state.status == PharmaciesStatus.error)
                      ? ErrorPanel(
                          failure: state.failure!,
                          onTryAgain: () =>
                              myPharmaciesCubit.getPharmaciesList(),
                        )
                      : (state.pharmacyListModel.isNotEmpty)
                          ? SingleChildScrollView(
                              controller: scrollController,
                              child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 16.h),
                                      if (state.pharmacyListModel.isNotEmpty)
                                        SearchWidget(
                                          textEditingController:
                                              state.searchController,
                                          focusNode: state.focusNode,
                                          title: "my_pharmacies.search".tr(),
                                          onChange: (value) {
                                            setState(() {});
                                          },
                                          onFieldSubmitted: (value) {
                                            myPharmaciesCubit.getPharmaciesList(
                                              isReload: true,
                                              isSearch: true,
                                            );
                                          },
                                          onCancel: () {
                                            state.searchController.clear();
                                            state.focusNode.unfocus();
                                            myPharmaciesCubit
                                                .changeSearchText('');
                                            myPharmaciesCubit
                                                .getPharmaciesList();
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
                                                  (state.rate ==
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
                                                        .changeOrderBy(
                                                            PharmacySortingEnum
                                                                .addingDate_asc);
                                                  }),
                                              _optionMenuWidget(
                                                  title:
                                                      "my_pharmacies.Newest to old"
                                                          .tr(),
                                                  onTap: () {
                                                    myPharmaciesCubit
                                                        .changeOrderBy(
                                                            PharmacySortingEnum
                                                                .addingDate_desc);
                                                  }),
                                            ],
                                          ),
                                        ],
                                      ),
                                      (state.status == PharmaciesStatus.loading)
                                          ? SizedBox(
                                              height: 1.sh / 1.7,
                                              child: const LoadingPanel())
                                          : (state.status ==
                                                  PharmaciesStatus.error)
                                              ? SizedBox(
                                                  height: 1.sh / 1.7,
                                                  child: ErrorPanel(
                                                    failure: state.failure!,
                                                    onTryAgain: () {
                                                      myPharmaciesCubit
                                                          .getPharmaciesList();
                                                    },
                                                  ))
                                              : (state.pharmacyListModel
                                                      .isEmpty)
                                                  ? Center(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            height: 100.h,
                                                          ),
                                                          CustomSvgIcon(
                                                              Assets.icons
                                                                  .noPharmacies,
                                                              size: 70.w),
                                                          SizedBox(
                                                            height: 8.h,
                                                          ),
                                                          Wrap(
                                                            alignment:
                                                                WrapAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "my_pharmacies.There is no Pharmacies"
                                                                    .tr(),
                                                                style: context
                                                                    .textTheme
                                                                    .headlineSmall,
                                                              ),
                                                              Text(
                                                                " ${"my_pharmacies.Scan QR-Code".tr()}",
                                                                style: context
                                                                    .textTheme
                                                                    .headlineSmall!
                                                                    .copyWith(
                                                                        color: context
                                                                            .theme
                                                                            .primaryColor),
                                                              ),
                                                              Text(
                                                                " ${"my_pharmacies.to add pharmacy".tr()}",
                                                                style: context
                                                                    .textTheme
                                                                    .headlineSmall!,
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 16.h,
                                                          ),
                                                          CustomContainer(
                                                            borderRadius: 30.r,
                                                            gradient: AppGradients
                                                                .greenGradient,
                                                            marginRight: 10,
                                                            marginLeft: 10,
                                                            child: TextButton(
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            40.w),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    CustomSvgIcon(
                                                                      Assets
                                                                          .icons
                                                                          .noPharmaciesScanIcon,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          5.w,
                                                                    ),
                                                                    Text(
                                                                      'my_pharmacies.Scan'
                                                                          .tr(),
                                                                      style: context
                                                                          .textTheme
                                                                          .headlineSmall!
                                                                          .copyWith(
                                                                              color: Colors.white),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                bool? temp = await context
                                                                    .push(AppPaths
                                                                        .pharmacies
                                                                        .scanQrPharmacy);
                                                                if (temp ??
                                                                    true) {
                                                                  myPharmaciesCubit
                                                                      .changeSearchText(
                                                                          '');
                                                                  myPharmaciesCubit
                                                                      .getPharmaciesList();
                                                                  myPharmaciesCubit
                                                                      .getArchivePharmaciesList();
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : SlidableAutoCloseBehavior(
                                                      child: ListView.separated(
                                                        itemBuilder: (context,
                                                                index) =>
                                                            PharmacyListWidget(
                                                          pharmacyModel: state
                                                                  .pharmacyListModel[
                                                              index],
                                                          onDismissed: () {},
                                                          onArchive:
                                                              (context) async {
                                                            await myPharmaciesCubit
                                                                .archivePharmacy(state
                                                                    .pharmacyListModel[
                                                                        index]
                                                                    .id);
                                                            myPharmaciesCubit
                                                                .refresh();
                                                          },
                                                          isArchive: false,
                                                        ),
                                                        separatorBuilder:
                                                            (context, index) =>
                                                                Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .only(
                                                                      start:
                                                                          20.w),
                                                          child: Container(
                                                              height: 1,
                                                              color:
                                                                  AppMaterialColors
                                                                      .grey
                                                                      .shade400),
                                                        ),
                                                        controller:
                                                            scrollController,
                                                        shrinkWrap: true,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        itemCount: state
                                                            .pharmacyListModel
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
                                if (state.searchController.text.isNotEmpty)
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: SearchWidget(
                                      textEditingController:
                                          state.searchController,
                                      focusNode: state.archiveFocusNode,
                                      title: "my_pharmacies.search".tr(),
                                      onChange: (value) {},
                                      onFieldSubmitted: (value) {
                                        if (value.isEmpty) {
                                          state.searchController.clear();
                                          state.focusNode.unfocus();
                                          myPharmaciesCubit
                                              .changeSearchText('');
                                          myPharmaciesCubit.getPharmaciesList();
                                        }
                                        myPharmaciesCubit
                                            .getArchivePharmaciesList(
                                          isReload: true,
                                          isSearch: true,
                                        );
                                      },
                                      onCancel: () {
                                        state.searchController.clear();
                                        state.focusNode.unfocus();
                                        myPharmaciesCubit.changeSearchText('');
                                        myPharmaciesCubit.getPharmaciesList();
                                      },
                                    ),
                                  ),
                                if (state.searchController.text.isEmpty)
                                  SizedBox(
                                    height: 0.1.sh,
                                  ),
                                const EmptyWidget(),
                              ],
                            ),
            );
          },
        ),
        floatingActionButton: GradientFloatingActionButton(
          onPressed: () async {
            bool? temp = await context.push(AppPaths.pharmacies.scanQrPharmacy);
            if (temp ?? true) {
              myPharmaciesCubit.getPharmaciesList();
              myPharmaciesCubit.getArchivePharmaciesList();
            }
          },
          icon: Icons.add,
        ));
  }

  PopupMenuEntry _optionMenuWidget(
      {required String title, required Function() onTap}) {
    return PopupMenuItem(onTap: onTap, child: Text(title));
  }
}

class GradientFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const GradientFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            HexColor.fromHex("#25D0BD"),
            HexColor.fromHex("#20AACC"),
          ],
          begin: AlignmentDirectional.centerStart,
          end: AlignmentDirectional.centerEnd,
        ),
      ),
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Icon(
          icon,
          color: !context.isDark ? AppColors.white : AppColors.black,
        ),
      ),
    );
  }
}
