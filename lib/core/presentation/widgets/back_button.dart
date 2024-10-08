import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBackButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color? color;
  final double? size;

  const CustomBackButton({super.key, this.onPressed, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? context.pop,
      child: Platform.isIOS
          ? Icon(
              Icons.arrow_back_ios_new,
              color: color,
              size: size,
            )
          : Icon(
              Icons.arrow_back,
              color: color,
              size: size,
            ),
    );
  }
}
