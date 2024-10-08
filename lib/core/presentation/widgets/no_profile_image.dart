import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/assets.gen.dart';
import '../resources/theme/app_material_color.dart';

class DefaultProfileImage extends StatelessWidget {
  const DefaultProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 42.0.r,
      backgroundColor: AppMaterialColors.green,
      foregroundColor: AppMaterialColors.green,
      foregroundImage: AssetImage(Assets.images.noUserPhoto.path),
    );
  }
}
