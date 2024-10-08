import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../router.dart';
import '../../utils/failures/base_failure.dart';
import '../../utils/parse_helpers/failure_parser.dart';

class ErrorPanel extends StatelessWidget {
  final Failure failure;
  final void Function()? onTryAgain;
  final bool goToLogIn;

  const ErrorPanel(
      {Key? key,
      required this.failure,
      this.onTryAgain,
      this.goToLogIn = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_rounded,
              color: Colors.red.shade300,
              size: 80.w,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Text(
                FailureParser.mapFailureToString(
                    failure: failure, context: context),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.red.shade300),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            if (onTryAgain != null)
              InkWell(
                onTap: onTryAgain,
                child: Container(
                  width: 180.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.red.shade200),
                  child: Center(
                    child: Text(
                      "qr_pharmacy.try_again".tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            if (goToLogIn)
              const SizedBox(
                height: 30,
              ),
            if (goToLogIn)
              InkWell(
                onTap: () {
                  context.go(AppPaths.auth.signIn);
                },
                child: Container(
                  width: 180.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).primaryColor),
                  child: Center(
                    child: Text(
                      "Go To LogIn",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
