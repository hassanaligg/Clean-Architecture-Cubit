import 'package:dawaa24/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchWidget extends StatefulWidget {
  final String? title;
  final Function(String value)? onChange;
  final Function(String value)? onFieldSubmitted;
  final Function()? onCancel;
  final FocusNode? focusNode;
  final TextEditingController? textEditingController;

  const SearchWidget(
      {super.key,
      this.title,
      this.onChange,
      this.onCancel,
      this.focusNode,
      this.textEditingController,
      this.onFieldSubmitted});

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        if (widget.onChange != null) {
          widget.onChange!(value);
        }
      },
      onFieldSubmitted: (value) {
        if (widget.onFieldSubmitted != null) {
          widget.onFieldSubmitted!(value);
        }
      },
      textInputAction: TextInputAction.search,
      focusNode: widget.focusNode,
      controller: widget.textEditingController,
      style: context.textTheme.titleSmall!
          .copyWith(color: HexColor.fromHex('#76738F')),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(16.sp),
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: HexColor.fromHex('#D8DEF5'), width: 2),
            borderRadius: BorderRadius.all(Radius.circular(12.r))),
        hintText: widget.title,
        hintStyle: context.textTheme.titleSmall!
            .copyWith(color: HexColor.fromHex('#76738F')),
        filled: true,
        fillColor: HexColor.fromHex('#E2E7FF').withOpacity(0.2),
        prefixIcon: Icon(
          Icons.search_sharp,
          color: HexColor.fromHex('#76738F'),
          size: 24.sp,
        ),
        suffixIcon: (widget.onCancel != null &&
                (widget.textEditingController?.text.isNotEmpty ?? false))
            ? IconButton(
                onPressed: widget.onCancel!,
                icon: Icon(
                  Icons.cancel_outlined,
                  color: HexColor.fromHex('#76738F'),
                ),
              )
            : null,
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: HexColor.fromHex('#D8DEF5'), width: 0.0),
            borderRadius: BorderRadius.all(Radius.circular(12.r))),
      ),
    );
  }
}
