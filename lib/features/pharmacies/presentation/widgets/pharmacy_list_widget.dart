import 'package:dawaa24/core/presentation/resources/assets.gen.dart';
import 'package:dawaa24/core/presentation/resources/theme/app_color.dart';
import 'package:dawaa24/core/presentation/widgets/network_image.dart';
import 'package:dawaa24/core/presentation/widgets/svg_icon.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/features/pharmacies/data/model/pharmacie_model.dart';
import 'package:dawaa24/features/pharmacies/data/model/working_time_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

import '../../../../router.dart';
import '../cubits/pharmacies_cubit/pharmacies_cubit.dart';

class PharmacyListWidget extends StatelessWidget {
  const PharmacyListWidget(
      {super.key,
      required this.pharmacyModel,
      required this.onDismissed,
      required this.onArchive,
      this.isArchive = false});

  final PharmacyModel pharmacyModel;
  final VoidCallback onDismissed;
  final bool isArchive;
  final void Function(BuildContext)? onArchive;

  bool isOpen(PharmacyModel pharmacy) {
    var currentDateTime = DateTime.now();
    var currentDayOfWeek = currentDateTime.weekday;
    var currentTime = currentDateTime.toLocal();
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
  Widget build(BuildContext context) {
    ActionPane actionPane = ActionPane(
      extentRatio: 0.4,
      motion: const ScrollMotion(),
      dismissible: DismissiblePane(onDismissed: onDismissed),
      dragDismissible: false,
      children: [
        SlidableAction(
          flex: 1,
          onPressed: (BuildContext context) {},
          backgroundColor: HexColor.fromHex("#EFF3F5"),
          widget: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomSvgIcon(Assets.icons.pinIcon, size: 15.sp),
              SizedBox(
                height: 4.h,
              ),
              Text(
                isArchive
                    ? "my_pharmacies.unpin".tr()
                    : "my_pharmacies.pin".tr(),
                style: TextStyle(
                    color: HexColor.fromHex("#4B4863"), fontSize: 9.sp),
              )
            ],
          ),
          autoClose: true,
          label: "",
          labelStyle:
              TextStyle(color: HexColor.fromHex("#4B4863"), fontSize: 1.sp),
        ),
        SlidableAction(
          flex: 1,
          onPressed: onArchive,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12.r),
              bottomRight: Radius.circular(12.r)),
          backgroundColor: HexColor.fromHex("#F9FAFF"),
          label: '',
          widget: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomSvgIcon(
                !isArchive
                    ? Assets.icons.archiveIcon
                    : Assets.icons.unarchiveIcon,
                size: 15.sp,
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                isArchive
                    ? "my_pharmacies.unarchive".tr()
                    : "my_pharmacies.archive".tr(),
                style: TextStyle(
                    color: HexColor.fromHex("#4B4863"), fontSize: 9.sp),
              )
            ],
          ),
          autoClose: true,
          labelStyle:
              TextStyle(color: HexColor.fromHex("#4B4863"), fontSize: 1.sp),
        ),
      ],
    );
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Slidable(
        key: ValueKey(pharmacyModel.id),
        closeOnScroll: true,
        startActionPane: context.isArabic ? actionPane : null,
        endActionPane: context.isArabic ? null : actionPane,
        useTextDirection: false,
        // startActionPane:actionPane : null,
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            context.push(AppPaths.pharmacies.pharmacyDetails,
                extra: pharmacyModel);
          },
          child: Row(
            children: [
              CustomNetworkImage(
                url: pharmacyModel.profileImage ?? '',
                width: 110.w,
                height: 110.w,
                isBase64: true,
                isLoad: false,
                borderRadius: BorderRadius.circular(12.r),
                errorIconSize: 40.w,
                errorBackgroundColor: HexColor.fromHex("#F9FAFF"),
                errorWidgetIcon: Image.asset(Assets.images.errorImage.path),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pharmacyModel.name,
                        style: context.textTheme.headlineMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomSvgIcon(
                            Assets.icons.addressIcon,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              pharmacyModel.address,
                              style: context.textTheme.headlineSmall!.copyWith(
                                  color: HexColor.fromHex("#25D0BD"),
                                  fontSize: 13.sp),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 5.5.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.r),
                                  color: isOpen(pharmacyModel)
                                      ? AppColors.green[300]!.withOpacity(0.15)
                                      : AppColors.red.withOpacity(0.15)),
                              child: Text(
                                isOpen(pharmacyModel)
                                    ? "pharmacy_details.open".tr()
                                    : "pharmacy_details.closed".tr(),
                                style: context.textTheme.titleSmall!.copyWith(
                                    color: isOpen(pharmacyModel)
                                        ? HexColor.fromHex("#15D956")
                                        : HexColor.fromHex("#DF6761")),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          if (pharmacyModel.distance != null)
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 5.5.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.r),
                                  color:
                                      AppColors.grey.shade100.withOpacity(0.15),
                                ),
                                child: Text(
                                  "${(pharmacyModel.distance ?? 0).toStringAsFixed(1)} ${pharmacyModel.distanceUnit}",
                                  style: context.textTheme.titleSmall!.copyWith(
                                    color: AppColors.grey.shade100,
                                  ),
                                  maxLines: 4,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
