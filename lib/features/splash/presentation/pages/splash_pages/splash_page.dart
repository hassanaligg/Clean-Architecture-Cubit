import 'package:dawaa24/core/presentation/resources/assets.gen.dart';
import 'package:dawaa24/core/presentation/widgets/custom_app_text.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:dawaa24/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late SplashCubit splashCubit;

  @override
  void initState() {
    splashCubit = SplashCubit();
    splashCubit.startCounter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, SplashState>(
      bloc: splashCubit,
      listener: (context, state) async {
        if (state is SplashNoConnection) {
          await context.push(AppPaths.splash.noInternet);
          splashCubit.retry();
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: Center(
              child: SvgPicture.asset(
                context.isDark
                    ? Assets.images.dawaaDarkLogo
                    : Assets.images.dawaaLogo,
              ),
            ),
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText.p14("From"),
                InkWell(
                  child: SvgPicture.asset(
                    Assets.images.nanoLogo,
                  ),
                  onTap: () {},
                ),
                SizedBox(height: 32.h),
              ],
            ));
      },
    );
  }
}
