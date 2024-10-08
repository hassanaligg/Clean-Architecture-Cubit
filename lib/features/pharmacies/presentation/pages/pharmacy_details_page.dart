import 'dart:developer';

import 'package:dawaa24/core/presentation/resources/theme/app_color.dart';
import 'package:dawaa24/core/presentation/widgets/back_button.dart';
import 'package:dawaa24/core/presentation/widgets/error_banner.dart';
import 'package:dawaa24/core/presentation/widgets/error_panel.dart';
import 'package:dawaa24/core/presentation/widgets/loading_banner.dart';
import 'package:dawaa24/core/presentation/widgets/loading_panel.dart';
import 'package:dawaa24/core/presentation/widgets/network_image.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/features/chat/domain/params/pharmacy_chat_page_params_model.dart';
import 'package:dawaa24/features/pharmacies/data/model/pharmacie_model.dart';
import 'package:dawaa24/features/pharmacies/presentation/cubits/pharmacy_details/pharmacy_details_cubit.dart';
import 'package:dawaa24/router.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/presentation/resources/assets.gen.dart';
import '../../../../core/services/launch_service.dart';
import '../../data/model/working_time_model.dart';

class PharmacyDetailsPage extends StatefulWidget {
  const PharmacyDetailsPage({
    super.key,
    required this.pharmacyModel,
    this.pharmacyId,
    this.isComingFromScanQR = false,
  });

  final PharmacyModel? pharmacyModel;
  final String? pharmacyId;
  final bool isComingFromScanQR;

  @override
  State<PharmacyDetailsPage> createState() => _PharmacyDetailsPageState();
}

class _PharmacyDetailsPageState extends State<PharmacyDetailsPage> {
  late final PharmacyDetailsCubit pharmacyDetailsCubit;
  bool pharmacyIsOpen = false;
  Set<Marker> markers = <Marker>{};

  bool isOpen(PharmacyModel pharmacy) {
    var currentDateTime = DateTime.now();
    var currentTime = currentDateTime.toLocal();

    var currentDayOfWeek = currentDateTime.weekday;
    currentDayOfWeek = currentDayOfWeek == 7 ? 0 : currentDayOfWeek;
    WorkingTimeModel? todayWorkingTime = pharmacy.workingTimes.firstWhere(
      (element) => element.workDay == currentDayOfWeek,
      orElse: () {
        return WorkingTimeModel(
            from: "", to: "", workDay: -1, is24Hours: false);
      },
    );
    if (todayWorkingTime.is24Hours) {
      return true;
    } else if (todayWorkingTime.workDay != -1) {
      DateFormat timeFormat = DateFormat("HH:mm", "en");
      DateTime fromParsed = timeFormat.parse(todayWorkingTime.from);
      DateTime toParsed = timeFormat.parse(todayWorkingTime.to);
      DateTime fromTime = DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        fromParsed.hour,
        fromParsed.minute,
      );

      DateTime toTime = DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        toParsed.hour,
        toParsed.minute,
      );
      if (currentTime.isAfter(fromTime) && currentTime.isBefore(toTime)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  void initState() {
    pharmacyDetailsCubit = PharmacyDetailsCubit();

    if (widget.pharmacyModel != null) {
      pharmacyDetailsCubit.fillPharmacyDetails(widget.pharmacyModel!);
      initInfo();
    } else if (widget.pharmacyId != null) {
      getPharmacyDetails();
    } else {
      log("error with passing data!");
      context.pop();
    }

    super.initState();
  }

  getPharmacyDetails() async {
    await pharmacyDetailsCubit.getPharmacyDetails(widget.pharmacyId ?? '');
    initInfo();
  }

  initInfo() {
    pharmacyIsOpen = isOpen(pharmacyDetailsCubit.state.pharmacyModel!);
    markers.add(Marker(
      markerId: MarkerId(pharmacyDetailsCubit.state.pharmacyModel!.id),
      position: LatLng(pharmacyDetailsCubit.state.pharmacyModel!.latitude,
          pharmacyDetailsCubit.state.pharmacyModel!.longitude),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PharmacyDetailsCubit, PharmacyDetailsState>(
      bloc: pharmacyDetailsCubit,
      builder: (context, state) {
        return state.status == PharmacyDetailsStatus.loading
            ? const LoadingPanel()
            : state.status == PharmacyDetailsStatus.error
                ? ErrorPanel(failure: state.failure!)
                : Scaffold(
                    appBar: AppBar(
                      title: Text(
                        pharmacyDetailsCubit.state.pharmacyModel?.name ?? "",
                      ),
                      leading: CustomBackButton(
                          color: context.isDark
                              ? AppColors.white
                              : AppColors.black),
                    ),
                    body: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: (state.status == PharmacyDetailsStatus.loading)
                            ? const LoadingPanel()
                            : (state.status == PharmacyDetailsStatus.error)
                                ? ErrorPanel(failure: state.failure!)
                                : (state.status ==
                                            PharmacyDetailsStatus.success ||
                                        state.status ==
                                            PharmacyDetailsStatus
                                                .addToMyPharmacyLoading ||
                                        state.status ==
                                            PharmacyDetailsStatus
                                                .addToMyPharmacyError)
                                    ? SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 150.h,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.r)),
                                              child: Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  CustomNetworkImage(
                                                    url: state.pharmacyModel!
                                                            .bannarImage ??
                                                        '',
                                                    height: 272.h,
                                                    width: 1.sw,
                                                    boxFit: BoxFit.fitWidth,
                                                    isBase64: true,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.r),
                                                    errorWidgetIcon:
                                                        Image.asset(Assets
                                                            .images
                                                            .pharamacyBackgroundDef
                                                            .path),
                                                  ),
                                                  Positioned.fill(
                                                    bottom: -100.h,
                                                    child: Center(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      200.r),
                                                          border: Border.all(
                                                            color:
                                                                AppColors.white,
                                                            width: 4.w,
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                              spreadRadius: 1,
                                                              blurRadius: 10,
                                                              offset:
                                                                  const Offset(
                                                                      0, 2),
                                                            ),
                                                          ],
                                                        ),
                                                        child: CustomNetworkImage(
                                                            url: state
                                                                    .pharmacyModel!
                                                                    .profileImage ??
                                                                '',
                                                            width: 140.w,
                                                            height: 140.w,
                                                            isBase64: true,
                                                            boxFit:
                                                                BoxFit.cover,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        200.r),
                                                            errorWidgetIcon:
                                                                Image.asset(Assets
                                                                    .images
                                                                    .errorImage
                                                                    .path)),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 60.h,
                                            ),
                                            Container(
                                              width: 80.w,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          22.r),
                                                  border: Border.all(
                                                      color: pharmacyIsOpen
                                                          ? AppColors
                                                              .green[300]!
                                                          : AppColors.red)),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 7.h,
                                                    width: 7.w,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: !pharmacyIsOpen
                                                            ? AppColors.red
                                                            : AppColors
                                                                .green[300]!),
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Text(
                                                    pharmacyIsOpen
                                                        ? "pharmacy_details.open"
                                                            .tr()
                                                        : "pharmacy_details.closed"
                                                            .tr(),
                                                    style: TextStyle(
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: pharmacyIsOpen
                                                            ? AppColors
                                                                .green[300]!
                                                            : AppColors.red),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            Text(state.pharmacyModel!.name,
                                                textAlign: TextAlign.center,
                                                style: context
                                                    .textTheme.headlineMedium),
                                            SizedBox(height: 5.h),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color:
                                                      AppColors.green.shade100,
                                                  size: 24.sp,
                                                ),
                                                const SizedBox(width: 5),
                                                Flexible(
                                                  child: Text(
                                                    state
                                                        .pharmacyModel!.address,
                                                    style: context.textTheme
                                                        .headlineSmall!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10.h),
                                            Directionality(
                                              textDirection: TextDirection.ltr,
                                              child: Text(
                                                "${state.pharmacyModel!.distance!.toStringAsFixed(2)} ${"pharmacy_details.km_away".tr()}",
                                                style:
                                                    TextStyle(fontSize: 13.sp),
                                              ),
                                            ),
                                            SizedBox(height: 10.h),
                                            InkWell(
                                              onTap: () {
                                                LunchUrlService().launchPhone(
                                                    state.pharmacyModel!.phone);
                                              },
                                              child: Text(
                                                state.pharmacyModel!.phone
                                                    .formatPhone(),
                                                textDirection:
                                                    TextDirection.ltr,
                                                // Always enforce left-to-right
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColors.green[100]),
                                              ),
                                            ),
                                            SizedBox(height: 15.h),
                                            Directionality(
                                              textDirection: TextDirection.ltr,
                                              child: Wrap(
                                                  // runAlignment: WrapAlignment.start,
                                                  alignment:
                                                      WrapAlignment.center,
                                                  // spacing: 10.w,
                                                  runSpacing: 10.h,
                                                  spacing: 15.w,
                                                  // crossAxisAlignment: WrapCrossAlignment.start,
                                                  children: state.pharmacyModel!
                                                      .workingTimes
                                                      .map((e) => slotWidget(
                                                          e,
                                                          context.locale
                                                              .languageCode))
                                                      .toList()),
                                            ),
                                            SizedBox(height: 15.h),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    context.push(
                                                        AppPaths.chatPaths
                                                            .pharmacyChatPage,
                                                        extra:
                                                            PharmacyChatPageParamsModel(
                                                          pharmacyName: state
                                                                  .pharmacyModel
                                                                  ?.name ??
                                                              '',
                                                          pharmacyId: state
                                                                  .pharmacyModel
                                                                  ?.id ??
                                                              "",
                                                          avatarUrl: state
                                                                  .pharmacyModel
                                                                  ?.profileImage ??
                                                              '',
                                                        ));
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.white,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            side: BorderSide(
                                                                color: AppColors
                                                                    .green
                                                                    .shade200,
                                                                width: 1.0,
                                                                style:
                                                                    BorderStyle
                                                                        .solid),
                                                          ),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  9.w)),
                                                  child: Icon(
                                                    Icons.chat_outlined,
                                                    color: context
                                                        .theme.primaryColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    "chat.coming_soon"
                                                        .tr()
                                                        .showToast(
                                                            toastGravity:
                                                                ToastGravity
                                                                    .CENTER);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.white,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            side: BorderSide(
                                                                color: AppColors
                                                                    .green
                                                                    .shade200,
                                                                width: 1.0,
                                                                style:
                                                                    BorderStyle
                                                                        .solid),
                                                          ),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  9.w)),
                                                  child: Icon(
                                                    Icons.call,
                                                    color: context
                                                        .theme.primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 15.h),
                                            SizedBox(
                                              height: 180.h,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16.r),
                                                child: GoogleMap(
                                                  initialCameraPosition:
                                                      CameraPosition(
                                                    target: LatLng(
                                                        state.pharmacyModel!
                                                            .latitude,
                                                        state.pharmacyModel!
                                                            .longitude),
                                                    zoom: 13,
                                                  ),
                                                  zoomGesturesEnabled: false,
                                                  rotateGesturesEnabled: false,
                                                  myLocationButtonEnabled:
                                                      false,
                                                  scrollGesturesEnabled: false,
                                                  markers: markers,
                                                ),
                                              ),
                                            ),
                                            if (state.status ==
                                                    PharmacyDetailsStatus
                                                        .addToMyPharmacyError &&
                                                widget.isComingFromScanQR)
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 15.h),
                                                child: ErrorBanner(
                                                    failure: state
                                                        .addToMyPharmacyFailure!),
                                              ),
                                            SizedBox(height: 16.h),
                                            (state.status ==
                                                        PharmacyDetailsStatus
                                                            .addToMyPharmacyLoading &&
                                                    widget.isComingFromScanQR)
                                                ? const LoadingBanner()
                                                : (widget.isComingFromScanQR)
                                                    ? ElevatedButton(
                                                        onPressed: () async {
                                                          String? responseStr =
                                                              await pharmacyDetailsCubit
                                                                  .addToMyPharmacy(widget
                                                                          .pharmacyId ??
                                                                      widget
                                                                          .pharmacyModel
                                                                          ?.id ??
                                                                      '');
                                                          if (responseStr !=
                                                              null) {
                                                            responseStr
                                                                .showToast();
                                                          }
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.white,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            side: BorderSide(
                                                                color: AppColors
                                                                    .green
                                                                    .shade200,
                                                                width: 1.0,
                                                                style:
                                                                    BorderStyle
                                                                        .solid),
                                                          ),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      23.w,
                                                                  vertical:
                                                                      16.h),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .add_circle_outline_sharp,
                                                              color: context
                                                                  .theme
                                                                  .primaryColor,
                                                            ),
                                                            SizedBox(
                                                              width: 4.w,
                                                            ),
                                                            Text(
                                                              "pharmacy_details.Add to My Pharmacies"
                                                                  .tr(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      12.sp,
                                                                  color: AppColors
                                                                      .green
                                                                      .shade200),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : const SizedBox.shrink(),
                                            SizedBox(
                                                height: 16.h +
                                                    MediaQuery.of(context)
                                                        .padding
                                                        .bottom),
                                          ],
                                        ),
                                      )
                                    : Center(
                                        child: Text(
                                            "failures.some_thing_wrong".tr()),
                                      )));
      },
    );
  }

  Widget slotWidget(WorkingTimeModel workingTimeModel, String local) {
    return Container(
        width: 0.4.sw,
        padding: EdgeInsets.symmetric(vertical: 5.h),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(
            30.r,
          ),
        ),
        child: Column(
          children: [
            Text(pharmacyDetailsCubit.getSlotDate(workingTimeModel, local)),
            if (workingTimeModel.is24Hours)
              Text("pharmacy_details.all_day".tr()),
            if (!workingTimeModel.is24Hours)
              Text(pharmacyDetailsCubit.getSlotTime(workingTimeModel, local)),
          ],
        ));
  }
}
