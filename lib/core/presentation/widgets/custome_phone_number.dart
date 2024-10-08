import 'package:dawaa24/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../features/auth/data/model/country_model.dart';
import '../../data/model/phone_number_model.dart';
import '../resources/theme/app_material_color.dart';
import '../services/validation_service.dart';
import 'country_code_drop_down.dart';
import 'custom_form_field.dart';

class CustomPhoneNumberWidget extends StatefulWidget {
  CustomPhoneNumberWidget({
    super.key,
    this.validateField = true,
    this.withPhoneNumber = true,
    this.withBorder = true,
    this.withFlag = false,
    this.enable = true,
    required this.countries,
    required this.onChange,
    required this.phoneNumberModel,
  }) {
    controller = TextEditingController();
    controller.text = phoneNumberModel.phoneNumber;
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
  }

  final PhoneNumberModel phoneNumberModel;
  final bool validateField;
  final bool withPhoneNumber;
  final bool withBorder;
  final bool withFlag;
  final bool enable;
  List<CountryModel> countries;
  final void Function(PhoneNumberModel) onChange;
  late final TextEditingController controller;

  @override
  State<CustomPhoneNumberWidget> createState() =>
      _CustomPhoneNumberWidgetState();
}

class _CustomPhoneNumberWidgetState extends State<CustomPhoneNumberWidget> {
  List<CountryModel>temp=[];
  @override
  void initState() {
    temp=widget.countries;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: CountryCodeChooser(
            withBorder: widget.withBorder,
            withFlag: widget.withFlag,
            enable: widget.enable,
            items: temp,
            onChanged: (CountryModel countryModel) {
              widget.onChange(
                  widget.phoneNumberModel.copyWith(countryModel: countryModel));
            },
            selectedItem: widget.phoneNumberModel.countryModel,
            onSearchChanged: (String dd) {
              temp=[];
              setState(() {});
            },
          ),
        ),
        SizedBox(width: 12.w),
        if (widget.withPhoneNumber)
          Expanded(
            flex: 2,
            child: CustomFormField(
              controller: widget.controller,
              onChange: (phoneNumber) {
                widget.onChange(
                    widget.phoneNumberModel.copyWith(phoneNumber: phoneNumber));
              },
              hintText: "000 0000 00",
              validator: ValidationService.phoneNumberFieldValidator,
              keyboardType: TextInputType.number,
              autoValidate: widget.validateField,
              prefixIcon: Container(),
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.text,
              fillColor: (context.isDark)
                  ? AppMaterialColors.black[100]
                  : AppMaterialColors.white,
            ),
          )
      ],
    );
  }
}
