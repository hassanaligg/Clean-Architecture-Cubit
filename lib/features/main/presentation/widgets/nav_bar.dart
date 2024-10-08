import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/presentation/resources/assets.gen.dart';

class NavBar extends StatefulWidget {
  final int pageIndex;
  final Function(int) onTap;

  NavBar({
    super.key,
    required this.pageIndex,
    required this.onTap,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      width: 1.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            spreadRadius: 4,
            blurRadius: 4,
          ),
        ],
      ),
      margin: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
      ),
      child: Row(
        children: [
          navItem(
            widget.pageIndex == 0
                ? Assets.icons.selectedHomeIcon
                : Assets.icons.homeIcon,
            "home_page.home_page".tr(),
            widget.pageIndex == 0,
            onTap: () => widget.onTap(0),
          ),
          navItem(
            Assets.icons.chatIcon,
            "chat.chat".tr(),
            widget.pageIndex == 1,
            onTap: () => widget.onTap(1),
          ),
          navItem(
            Assets.icons.notificationsIcon,
            "notification.notifications_title".tr(),
            widget.pageIndex == 2,
            onTap: () => widget.onTap(2),
          ),
        ],
      ),
    );
  }

  Widget navItem(
    String icon,
    String name,
    bool selected, {
    Function()? onTap,
  }) {
    return Expanded(
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 24.h,
              width: 24.w,
              child: SvgPicture.asset(
                icon,
                color: selected
                    ? AppMaterialColors.green.shade200
                    : AppMaterialColors.black,
              ),
            ),
            Text(
              name,
              style: TextStyle(
                  fontSize: 12.sp,
                  color: selected
                      ? AppMaterialColors.green.shade200
                      : AppMaterialColors.black),
            )
          ],
        ),
      ),
    );
  }
}
