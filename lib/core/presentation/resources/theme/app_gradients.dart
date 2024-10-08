import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';
import 'package:flutter/material.dart';

class AppGradients {
  static LinearGradient greenGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppMaterialColors.green.shade100,
      AppMaterialColors.green.shade200
    ],
  );
    static LinearGradient continerGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppMaterialColors.green.shade100,
      AppMaterialColors.green.shade200],
  );

  static LinearGradient greenGradientHorizontal = LinearGradient(
    begin: AlignmentDirectional.centerStart,
    end: AlignmentDirectional.centerEnd,
    colors: [
      AppMaterialColors.green.shade100,
      AppMaterialColors.green.shade200
    ],
  );

  static LinearGradient darkGradientHorizontal = LinearGradient(
    begin: AlignmentDirectional.centerStart,
    end: AlignmentDirectional.centerEnd,
    colors: [
      AppMaterialColors.black.shade50,
      AppMaterialColors.black.shade50,
    ],
  );
  static LinearGradient shadow = LinearGradient(
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
    colors: [
      Colors.black.withOpacity(0.5),
      Colors.transparent,
    ],
  );

  static LinearGradient greenGradientVertical = LinearGradient(
    begin: AlignmentDirectional.bottomCenter,
    end: AlignmentDirectional.topCenter,
    colors: [
      AppMaterialColors.green.shade200.withOpacity(0.5),
      Colors.white.withOpacity(0.05),
    ],
  );

  static LinearGradient cerulean = LinearGradient(
    begin: const Alignment(0.5, 0),
    end: const Alignment(0.5, 1),
    colors: [AppMaterialColors.green[200]!, AppMaterialColors.green[200]!],
  );

  static  LinearGradient polorMorningGlory = const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.bottomRight,
    colors: [
      AppMaterialColors.polor,
      AppMaterialColors.morningGlory,
    ],
  );
}
