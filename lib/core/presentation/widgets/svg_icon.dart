import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgIcon extends StatelessWidget {
  final String path;
  final double? size;
  final Color? color;
  final BoxFit fit;
  final VoidCallback? onPress;

  const CustomSvgIcon(
    this.path, {
    Key? key,
    this.size,
    this.color,
    this.onPress,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onPress,
        child: SvgPicture.asset(
          path,
          width: size,
          height: size,
          color: color,
          fit: fit,
        ),
      ),
    );
  }
}
