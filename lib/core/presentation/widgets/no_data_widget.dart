import 'package:dawaa24/core/utils/extentions.dart';
import 'package:flutter/material.dart';


class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.warning_rounded,
                  color:
                  context.isDark ? Colors.white : Colors.black54,
                ),
              ),
              Text(
                "There is no data",
                style: context.textTheme.bodyLarge!.copyWith(
                  color:
                  context.isDark ? Colors.white : Colors.black54,
                ),
              ),
            ],
          )),
    );
  }
}
