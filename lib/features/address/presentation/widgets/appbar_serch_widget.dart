import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppBarSearchWidget extends StatelessWidget {
  const AppBarSearchWidget(
      {super.key, this.onTap, this.inputType = TextInputType.text});
  final TextInputType inputType;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlignVertical: TextAlignVertical.center,
      autofocus: false,
      keyboardType: inputType,
      decoration:  InputDecoration(
        fillColor: Colors.transparent,
        filled: true,
        prefixIcon: const Icon(Icons.search),
        hintText: "address.search_address".tr(),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
      onTap: onTap,
      textAlign: TextAlign.start,
    );
  }
}
