import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'offer_widget.dart';

class SliderHomePage extends StatelessWidget {
  const SliderHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 20.w),
      child: SizedBox(
        height: 140.h,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return const OfferWidget();
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 10.w,
              );
            },
            itemCount: 3),
      ),
    );
  }
}
