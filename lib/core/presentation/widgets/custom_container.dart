import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final Color? borderColor;
  final Color? backgroundColor;
  final double marginLeft;
  final double marginRight;
  final double marginTop;
  final double marginBottom;
  final EdgeInsets? allPadding;
  final double tLRadius;
  final double bLRadius;
  final double tRRadius;
  final double bRRadius;
  final double borderWidth;
  final Alignment? alignment;
  final Widget? child;
  final Gradient? gradient;

  const CustomContainer(
      {Key? key,
      this.width,
      this.height,
      this.borderRadius = 0.0,
      this.borderColor,
      this.backgroundColor,
      this.marginLeft = 0.0,
      this.marginRight = 0.0,
      this.marginBottom = 0.0,
      this.marginTop = 0.0,
      this.allPadding,
      this.tLRadius = 0.0,
      this.bLRadius = 0.0,
      this.tRRadius = 0.0,
      this.bRRadius = 0.0,
      this.borderWidth = 1,
      this.child,
      this.gradient,
      this.alignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: alignment,
      margin: EdgeInsets.only(
          left: marginLeft,
          right: marginRight,
          bottom: marginBottom,
          top: marginTop),
      padding: allPadding ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: backgroundColor,
        gradient: gradient,
        borderRadius: borderRadius != 0.0
            ? BorderRadius.circular(borderRadius)
            : BorderRadius.only(
                topLeft: Radius.circular(tLRadius),
                topRight: Radius.circular(tRRadius),
                bottomRight: Radius.circular(bRRadius),
                bottomLeft: Radius.circular(bLRadius),
              ),
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderWidth,
        ),
      ),
      child: child,
    );
  }
}
