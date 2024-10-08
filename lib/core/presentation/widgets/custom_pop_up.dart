import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPopup extends StatefulWidget {
  final String title;
  final String? body;
  final Widget? icon;
  final Widget? content;
  final Widget? customContent;
  final double? boarderRadius;
  final double? padding;
  final Color? backgroundColor;

  const CustomPopup(
      {super.key,
      required this.title,
      this.body,
      this.icon,
      this.boarderRadius,
      this.padding,
      this.customContent,
      this.backgroundColor,
      this.content});

  @override
  State<CustomPopup> createState() => _CustomPopupState();
}

class _CustomPopupState extends State<CustomPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: widget.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            widget.boarderRadius ?? 16.r), // Adjust the border radius
      ),
      child: Container(
        padding: EdgeInsets.all(widget.padding ?? 35.w),
        child: widget.customContent ??
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.icon != null) widget.icon!,
                SizedBox(height: 16.h),
                Text(widget.title, textAlign: TextAlign.center),
                SizedBox(height: 24.h),
                widget.content!,
              ],
            ),
      ),
    );
  }
}
