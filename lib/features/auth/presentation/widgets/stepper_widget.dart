import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:steps_indicator/steps_indicator.dart';
import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';

class StepperWidget extends StatefulWidget {
  final int currentStep;

  const StepperWidget({Key? key, required this.currentStep}) : super(key: key);

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  @override
  Widget build(BuildContext context) {
    return StepsIndicator(
      selectedStep: widget.currentStep,
      nbSteps: 6,
      doneLineColor: AppMaterialColors.green.shade200,
      undoneLineThickness: 6,
      doneLineThickness: 6,
      selectedStepWidget: Container(
        width: 18.h,
        height: 18.h,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: AppMaterialColors.green.shade200),
      ),
      unselectedStepWidget: Container(
        width: 18.h,
        height: 18.h,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: AppMaterialColors.grey.shade50),
      ),
      doneStepWidget: Container(
        width: 18.h,
        height: 18.h,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: AppMaterialColors.green.shade200),
      ),
      undoneLineColor: AppMaterialColors.grey.shade50,
      isHorizontal: true,
      lineLength: 35.w,
      enableLineAnimation: false,
      enableStepAnimation: false,
    );
  }
}
