import 'package:dawaa24/core/presentation/resources/theme/app_gradients.dart';
import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';
import 'package:flutter/material.dart';

ContinuousRectangleBorder continuousRectangleBorder =
    const ContinuousRectangleBorder();

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final Color? color;
  final bool isGradients;

  const CustomAppbar(
      {super.key,
      required this.title,
      this.actions,
      this.leading,
      this.bottom,
      this.color,
      this.isGradients = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.3,
      title: Text(title,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: isGradients
                  ? AppMaterialColors.white
                  : AppMaterialColors.black)),
      actions: actions,
      shape: continuousRectangleBorder,
      centerTitle: true,
      leading: leading,
      backgroundColor: color,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient:
                isGradients ? AppGradients.greenGradientHorizontal : null),
      ),
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
