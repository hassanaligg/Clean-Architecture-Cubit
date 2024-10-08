import 'package:dawaa24/core/presentation/resources/assets.gen.dart';
import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';
import 'package:dawaa24/core/presentation/widgets/custom_button.dart';
import 'package:dawaa24/core/presentation/widgets/svg_icon.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  double headerHeight = 1.sh;
  double heartHeight = 1.sw;
  double headerRadius = 0;
  double top = -100;
  double left = 0;
  double opacity = 0;
  Offset buttonOffset = const Offset(0, 2);
  Offset logoOffset = const Offset(0, -.5);

  Duration duration = const Duration(milliseconds: 800);
  Curve curve = Curves.fastOutSlowIn;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      headerHeight = .4.sh;
      headerRadius = headerHeight.r / 2;
      heartHeight = 125.h;
      top = .4.sh - heartHeight / 1.7;
      left = 1.sw / 2 - heartHeight / 2;
      opacity = 1;

      buttonOffset = const Offset(0, 0);
      logoOffset = const Offset(0, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedContainer(
            duration: duration,
            curve: curve,
            height: headerHeight,
            width: 1.sw,
            decoration: BoxDecoration(
              color: context.theme.primaryColor,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(headerRadius),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: duration,
            curve: curve,
            top: top,
            left: left,
            child: AnimatedContainer(
              duration: duration,
              curve: curve,
              width: heartHeight,
              height: heartHeight,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(heartHeight / 2),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    color: context.theme.primaryColor.withOpacity(.2),
                  ),
                ],
              ),
              child: Center(
                child: Lottie.asset(
                  Assets.animation.healthcareLottie,
                ),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: .4.sh + 100.h),
              Hero(
                tag: 'dawaa24Logo',
                child: AnimatedSlide(
                  duration: duration,
                  curve: curve,
                  offset: logoOffset,
                  child: CustomSvgIcon(
                    context.isDark
                        ? Assets.images.dawaaDarkLogo
                        : Assets.images.dawaaLogo,
                    size: 67.h,
                  ),
                ),
              ),
              SizedBox(height: 42.h),
              AnimatedSlide(
                duration: duration,
                curve: curve,
                offset: buttonOffset,
                child: AnimatedOpacity(
                  duration: duration,
                  curve: curve,
                  opacity: opacity,
                  child: Column(
                    children: [
                      Text(
                        'sign_in.Welcome_to'.tr(),
                        style: context.theme.textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.sp,
                          // color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'sign_in.Better healthcare, better tomorrow'.tr(),
                        style: context.theme.textTheme.bodyMedium!.copyWith(
                          // color: Colors.black,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              AnimatedSlide(
                duration: duration,
                curve: curve,
                offset: buttonOffset,
                child: AnimatedOpacity(
                  duration: duration,
                  curve: curve,
                  opacity: opacity,
                  child: Column(
                    children: [
                      Opacity(
                        opacity: .38,
                        child: Lottie.asset(
                          Assets.animation.arrowLottie,
                          width: 60.sp,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomButton(
                        onTap: () {
                          context.push(AppPaths.auth.signIn);
                        },
                        width: .5.sw,
                        height: 50.h,
                        raduis: 25.r,
                        withGradient: true,
                        child: Center(
                          child: Text(
                            'sign_in.get_started'.tr(),
                            style: TextStyle(
                              color: AppMaterialColors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(30.h)),
            ],
          ),
        ],
      ),
    );
  }
}
