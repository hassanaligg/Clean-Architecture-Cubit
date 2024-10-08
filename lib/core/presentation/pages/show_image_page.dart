import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';
import 'package:dawaa24/core/presentation/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';

import '../../domain/params/show_image_params.dart';
import '../resources/assets.gen.dart';
import '../widgets/network_image.dart';

class ShowImagePage extends StatelessWidget {
  const ShowImagePage({super.key, required this.params});
  final ShowImageParams params;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: Stack(
          children: [
            Center(
              child: params.isBase64
                  ? getImageBase64(params.image)
                  : CustomNetworkImage(
                url: params.image,
                boxFit: BoxFit.contain,
              ),
            ),
            PositionedDirectional(
              start: 20.w,
              top: 40.h,
              child: GestureDetector(
                onTap: () {
                  context.pop();

                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppMaterialColors.green.shade200),
                  child: CustomSvgIcon(
                    Assets.icons.cancelIcon,
                    size: 10.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getImageBase64(String image) {
    var imageBase64 = image;
    const Base64Codec base64 = Base64Codec();
    if (imageBase64 == null) return Container();
    var bytes = base64.decode(imageBase64);
    return Image.memory(
      bytes,
      fit: BoxFit.cover,
    );
  }
}
