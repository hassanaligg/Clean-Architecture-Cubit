import 'package:dawaa24/core/presentation/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/presentation/blocs/theme_bloc/theme_bloc.dart';
import '../../../../core/presentation/resources/assets.gen.dart';

PreferredSizeWidget homeAppBar({
  required BuildContext context,
  required ThemeBloc themeBloc,
}) {
  return AppBar(
    elevation: 0.0,
    flexibleSpace: Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      child: CustomSvgIcon(Assets.icons.dawaaAppBarIcon),
    ),
    actions: [
      // IconButton(
      //     onPressed: () {
      //       themeBloc.add(ChangeThemeEvent(!context.isDark));
      //     },
      //     icon: const Icon(Icons.dark_mode)),
      // IconButton(
      //     onPressed: () {
      //       context.push(AppPaths.chatPaths.pharmacyChatListPage);
      //     },
      //     icon: const Icon(
      //       Icons.chat,
      //       color: Colors.black,
      //     )),
      // BlocProvider(
      //   create: (context) => LogOutCubit(),
      //   child: BlocBuilder<LogOutCubit, LogOutState>(
      //     builder: (context, state) {
      //       return IconButton(
      //         icon: Icon(
      //           Icons.logout,
      //           color: context.isDark ? Colors.white : Colors.black,
      //         ),
      //         onPressed: () {
      //           showDialog(
      //               context: context,
      //               builder: (BuildContext contextDialog) {
      //                 return CustomDialog(
      //                   title: "drawer.Logout".tr(),
      //                   descriptions: "drawer.confirm_logout".tr(),
      //                   text: '',
      //                   onPress: () {
      //                     BlocProvider.of<LogOutCubit>(context).logOut();
      //                   },
      //                   withButton: false,
      //                   img: null,
      //                   isActiveCancelButton: true,
      //                 );
      //               });
      //         },
      //       );
      //     },
      //   ),
      // ),

      // IconButton(
      //   onPressed: () {},
      //   icon: CustomSvgIcon(Assets.icons.searchBlack),
      // ),
      // IconButton(
      //   onPressed: () {},
      //   icon: Badge.Badge(
      //     showBadge: true,
      //     badgeContent: const Text(
      //       "2",
      //       style: TextStyle(color: Colors.white),
      //     ),
      //     child: CustomSvgIcon(Assets.icons.dark),
      //   ),
      //   visualDensity:
      //   const VisualDensity(horizontal: VisualDensity.minimumDensity),
      // ),
      SizedBox(width: 8.w),
    ],
    // leading: IconButton(
    //     onPressed: () {
    //       context.push(AppPaths.mainPaths.notificationPage);
    //     },
    //     icon: Image.asset(
    //       Assets.icons.bell.path,
    //       color: context.theme.primaryColor,
    //       width: 21.w,
    //     )),
  );
}
