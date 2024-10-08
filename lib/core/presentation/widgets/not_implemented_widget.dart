import 'package:dawaa24/core/utils/extentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotImplementedWidget extends StatelessWidget {
  final Widget child;
  String? message;
  bool otherSnackBar;

  NotImplementedWidget(
      {Key? key, required this.child, this.message, this.otherSnackBar = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        otherSnackBar
            ? (message??"chat.coming_soon".tr()).showToast(toastGravity: ToastGravity.CENTER)
            : ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: HexColor.fromHex('#1DA4CA'),
                  content: Text(
                    message ?? 'chat.coming_soon'.tr(),
                    style: context.textTheme.headlineMedium!
                        .copyWith(color: Colors.white),
                  ),
                ))
                .closed
                .then(
                    (value) => ScaffoldMessenger.of(context).clearSnackBars());
      },
      child: IgnorePointer(
        child: Opacity(
          opacity: 0.5,
          child: child,
        ),
      ),
    );
  }
}
