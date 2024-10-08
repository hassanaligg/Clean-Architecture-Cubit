import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostOptionWidget extends StatelessWidget {
  final double height;
  final double width;
  final String title;
  final bool isSvg;
  final String? iconPath;
  final IconData? iconData;
  final VoidCallback? onTap;

  const PostOptionWidget({
    super.key,
    required this.height,
    required this.width,
    required this.title,
    this.iconPath,
    this.iconData,
    this.isSvg = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _buildCreatePostOptionWidget();
  }

  Widget _buildCreatePostOptionWidget() {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: LayoutBuilder(builder: (context, cons) {
              return Center(
                child: SizedBox(
                  height: height * 0.6,
                  width: height * 0.6,
                  child: iconData != null
                      ? Icon(
                          iconData!,
                        )
                      : iconPath != null
                          ? isSvg
                              ? SvgPicture.asset(
                                  iconPath!,
                                )
                              : Image.asset(iconPath!)
                          : null,
                ),
              );
            }),
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}
