import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/blocs/theme_bloc/theme_bloc.dart';
import '../../../../di/injection.dart';
import '../widgets/address_home_widget.dart';
import '../widgets/ask_container_widget.dart';
import '../widgets/for_you_widget.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/slider_home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var themeBloc = getIt<ThemeBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context: context, themeBloc: themeBloc),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AddressHomeWidget(),
            SizedBox(
              height: 16.h,
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.local_hospital_outlined,
                      color: context.theme.primaryColor,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "my_pharmacies.title".tr(),
                      style: context.textTheme.titleLarge!
                          .copyWith(fontSize: 18.sp),
                    )
                  ],
                ),
              ),
              onTap: () {
                // context.push(AppPaths.pharmacies.myPharmacies);
                context.push(AppPaths.pharmacies.pharmacies);
              },
            ),
            SizedBox(
              height: 16.h,
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      color: context.theme.primaryColor,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "profile.edit_profile".tr(),
                      style: context.textTheme.titleLarge!
                          .copyWith(fontSize: 18.sp),
                    ),
                  ],
                ),
              ),
              onTap: () {
                context.push(AppPaths.auth.editProfilePage);
              },
            ),
            SizedBox(
              height: 16.h,
            ),
            const SliderHomePage(),
            SizedBox(
              height: 16.h,
            ),
            const ForYouWidget(),
            SizedBox(
              height: 16.h,
            ),
            const AskContainerWidget(),
            SizedBox(
              height: 16.h,
            ),
            // const CategoryWidget(),
            // const ServicesWidget(),
            //
            // SizedBox(
            //   height: 16.h,
            // ),
            // const ReadingWidget(),
            // SizedBox(
            //   height: 16.h,
            // ),
            // Container(
            //   width: 1.sw,
            //   height: 150.h,
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: ExactAssetImage(
            //           Assets.images.homeStaticImg.path),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            // SizedBox(height: 16.h,),
            // const ProductsWidget(),
            // SizedBox(height: 150.h,)
          ],
        ),
      ),
    );
  }
}
