import 'dart:math' as math; // import this

import 'package:dawaa24/core/presentation/widgets/svg_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/assets.gen.dart';
import '../resources/theme/app_gradients.dart';

PreferredSizeWidget mainAppBar({
  isBack = false,
  required BuildContext context,
}) {
  return AppBar(
    elevation: 0.4,
    flexibleSpace: Container(
      decoration: BoxDecoration(gradient: AppGradients.greenGradientHorizontal),
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      child: CustomSvgIcon(Assets.images.dawaaWhiteLogo),
    ),
    leading: IconButton(
      icon: Transform(
        alignment: Alignment.center,
        transform: (context.locale.languageCode == 'ar')
            ? Matrix4.rotationY(math.pi)
            : Matrix4.rotationY(0),
        child: CustomSvgIcon(
          isBack ? Assets.icons.backIcon : Assets.icons.drawerMenu,
          color: Colors.white,
        ),
      ),
      onPressed: () {

      },
    ),
    actions: [
      IconButton(
        onPressed: () {

        },
        icon: CustomSvgIcon(Assets.icons.search),
        padding: EdgeInsets.zero,
        visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity),
      ),
      // BlocBuilder<CartCubit, CartState>(
      //   builder: (context, state) {
      //     return IconButton(
      //       onPressed: () {
      //         context.push(AppPaths.cart.myCart);
      //       },
      //       icon: Badge.Badge(
      //         showBadge: state.items.isNotEmpty,
      //         badgeContent: Text(
      //           state.itemsCount().toString(),
      //           style: const TextStyle(color: Colors.white),
      //         ),
      //         child: CustomSvgIcon(Assets.icons.cart),
      //       ),
      //       visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity),
      //     );
      //   },
      // ),
      // NotImplementedWidget(
      //   child: IconButton(
      //     onPressed: () {
      //       context.push(AppPaths.notification.notificationList);
      //     },
      //     icon: CustomSvgIcon(Assets.icons.bell),
      //     padding: EdgeInsets.zero,
      //     visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity),
      //   ),
      // ),
      SizedBox(
        width: 8.w,
      ),
    ],
  );
}
