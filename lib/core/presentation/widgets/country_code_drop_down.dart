import 'package:dawaa24/core/presentation/resources/theme/app_material_color.dart';
import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/features/auth/data/model/country_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../features/auth/presentation/widgets/custom_text_filed.dart';

class CountryCodeChooser extends StatefulWidget {
  final List<CountryModel> items;
  final void Function(CountryModel) onChanged;
  final void Function(String) onSearchChanged;
  final CountryModel selectedItem;
  final bool withBorder;
  final bool withFlag;
  final bool enable;

  const CountryCodeChooser(
      {super.key,
      required this.items,
      required this.onChanged,
      this.withBorder = true,
      this.withFlag = false,
      this.enable = true,
      required this.selectedItem,
      required this.onSearchChanged});

  @override
  State<CountryCodeChooser> createState() => _CountryCodeChooserState();
}

class _CountryCodeChooserState extends State<CountryCodeChooser> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.enable) {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return _CountryBottomSheet(
                items: widget.items,
                onChanged: widget.onChanged,
                onSearchChanged: widget.onSearchChanged,
              );
            },
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: widget.withBorder
                  ? AppMaterialColors.grey.shade300
                  : Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
        ),
        padding: EdgeInsets.all(widget.withFlag ? 0.w : 14.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.withFlag)
              Row(
                children: [
                  Text(
                    widget.selectedItem.flag!,
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: AppMaterialColors.grey.shade400,
                  ),
                ],
              ),
            Text(
              widget.selectedItem.code!,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp),
            ),
            if (widget.withFlag)
              Row(
                children: [
                  SizedBox(
                    width: 15.w,
                  ),
                  Container(
                      width: 2,
                      height: 20.h,
                      color: context.isDark
                          ? AppMaterialColors.white
                          : AppMaterialColors.grey.shade400),
                ],
              ),
            if (!widget.withFlag) SizedBox(width: 16.w),
            if (!widget.withFlag)
              Icon(
                Icons.keyboard_arrow_down,
                color: AppMaterialColors.grey.shade400,
              ),
          ],
        ),
      ),
    );
  }
}

class _CountryBottomSheet extends StatefulWidget {
  final List<CountryModel> items;
  final Function(CountryModel) onChanged;
  final Function(String) onSearchChanged;

  const _CountryBottomSheet({
    required this.items,
    required this.onChanged,
    required this.onSearchChanged,
  });

  @override
  __CountryBottomSheetState createState() => __CountryBottomSheetState();
}

class __CountryBottomSheetState extends State<_CountryBottomSheet> {
  late List<CountryModel> filteredItems;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
  }

  void _filterItems(String searchText) {
    setState(() {
      filteredItems = widget.items
          .where((country) =>
              country.name!.toLowerCase().contains(searchText.toLowerCase()) ||
              country.code!.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            height: 6,
            width: 50.w,
            decoration: BoxDecoration(
              color: AppMaterialColors.grey.shade400,
              borderRadius: BorderRadius.all(Radius.circular(15.r)),
            ),
          ),
          SizedBox(height: 10.h),
          CustomTextFiled(
            controller: searchController,
            hintText: 'otp_page.Search'.tr(),
            onChanged: _filterItems,
            prefixIcon: Padding(
              padding: EdgeInsetsDirectional.only(start: 20.w, end: 10.w),
              child: const Icon(
                Icons.search,
              ),
            ),
          ),
          SizedBox(height: 30.h),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (ctx, i) {
                return InkWell(
                  onTap: () {
                    widget.onChanged(filteredItems[i]);
                    Navigator.of(context).pop();
                  },
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          filteredItems[i].flag!,
                          style: TextStyle(fontSize: 25.w),
                        ),
                        SizedBox(width: 20.w),
                        Text(filteredItems[i].code!),
                        SizedBox(width: 20.w),
                        Text(filteredItems[i].name!),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
