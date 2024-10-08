import 'package:flutter/material.dart';

import '../resources/theme/app_material_color.dart';

class Common {
  //this widget will be used for distance etc
  static Widget distance({
    double pLeft = 0.0,
    double pRight = 0.0,
    double pBottom = 0.0,
    double pTop = 0.0,
    double dis = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: pTop,
        right: pRight,
        left: pLeft,
        bottom: pBottom,
      ),
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.location_on,
            size: 12,
            // color: ThemeColors.cerulean,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            "${dis.toStringAsFixed(2)} Km",
            //style: ThemeStyle.blackLight.copyWith(fontSize: 12),
          )
        ],
      ),
    );
  }

  //this widget make small balls
  static Widget ball({Color? color}) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        color: color??AppMaterialColors.green,
        border: Border.all(
          color:
          AppMaterialColors.white, //                   <--- border color
          width: 1.0,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      child: const Icon(
        Icons.check,
        size: 15,
        color: AppMaterialColors.white,
      ),
    );
  }



//this widget will draw line
}
