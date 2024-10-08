import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dawaa24/features/address/data/model/address_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_places_flutter/model/prediction.dart';

import '../../../../core/presentation/resources/assets.gen.dart';
import '../../../../core/presentation/resources/theme/app_material_color.dart';
import '../../../../core/presentation/services/validation_service.dart';
import '../../../../core/presentation/widgets/back_button.dart';
import '../../../../core/presentation/widgets/custom_app_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/presentation/widgets/custom_button.dart';
import '../../../../core/presentation/widgets/custom_form_field.dart';
import '../../../../core/presentation/widgets/error_banner.dart';
import '../../../../core/presentation/widgets/loading_banner.dart';
import '../../../../core/presentation/widgets/svg_icon.dart';
import '../cubits/add_address_cubit/add_address_cubit.dart';
import 'package:google_places_flutter/google_places_flutter.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({super.key, this.addressModel});

  final AddressModel? addressModel;

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  final TextEditingController controller = TextEditingController();
  late AddAddressCubit addAddressCubit;

  @override
  void initState() {
    addAddressCubit = AddAddressCubit();
    if (widget.addressModel != null) {
      addAddressCubit.fillEditMode(widget.addressModel!);
    } else {
      // addAddressCubit.initMarkLocation();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddAddressCubit, AddAddressState>(
      bloc: addAddressCubit,
      listener: (context, state) {
        if (state.status == AddAddressStatus.success) {
          if (widget.addressModel != null) {
            Fluttertoast.showToast(
                msg: "address.address_update_successful".tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                fontSize: 16.sp);
          } else {
            Fluttertoast.showToast(
                msg: "address.address_successfully".tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                fontSize: 16.sp);
          }
          // context.pushReplacement(AppPaths.address.addressList);
          context.pop();
          context.pop(true);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppbar(
            title: 'address.manage_addresses'.tr(),
            leading: CustomBackButton(
              color: Colors.black,
              size: 18.sp,
            ),
            isGradients: false,
          ),
          body: Stack(
            children: [
              GoogleMap(
                onMapCreated: (GoogleMapController mapController) {
                  addAddressCubit.setGoogleMapController(mapController);
                },
                onCameraMove: (position) {
                  addAddressCubit.onMoveLocation(position);
                },
                onCameraIdle: () async {
                  addAddressCubit.getLocationDescFiled();
                },
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: state.currentPosition!,
                  zoom: 13,
                ),
                zoomControlsEnabled: false,
                zoomGesturesEnabled: true,
                mapToolbarEnabled: true,
                rotateGesturesEnabled: true,
                myLocationEnabled: false,
              ),
              Positioned(
                  top: 10.h,
                  left: 0,
                  right: 0,
                  child: placesAutoCompleteTextField()),
              const Center(
                child: Icon(
                  Icons.location_on,
                  size: 40,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          bottomSheet: DraggableScrollableSheet(
            minChildSize: .2,
            maxChildSize: .80,
            snap: true,
            expand: false,
            initialChildSize: 0.30,
            controller: state.draggableScrollableController,
            builder: (context, scrollController) {
              return Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                    color: AppMaterialColors.white),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    // color: AppMaterialColors.white
                  ),
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Form(
                        key: state.formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 8.h,
                            ),
                            Center(
                                child: IconButton(
                              icon: Opacity(
                                opacity: 0.8,
                                child: Container(
                                  width: 25.w,
                                  height: 10.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: context.isDark
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                              onPressed: () {
                                if (state.draggableScrollableController.size >
                                    0.3) {
                                  state.draggableScrollableController.animateTo(
                                      0.09,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.linear);
                                } else {
                                  state.draggableScrollableController.animateTo(
                                      1,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.linear);
                                }
                              },
                            )),
                            Text(
                              "address.address_details".tr(),
                              style: context.textTheme.displaySmall,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    addAddressCubit
                                        .changeSelectedLocationType(true);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 18.w),
                                    decoration: BoxDecoration(
                                      color: state.isSelectHome
                                          ? AppMaterialColors.green.shade200
                                          : null,
                                      borderRadius: BorderRadius.circular(19),
                                      border: state.isSelectHome
                                          ? null
                                          : Border.all(color: Colors.grey),
                                    ),
                                    child: Row(
                                      children: [
                                        CustomSvgIcon(
                                          Assets.icons.addressHomeIcon,
                                          color: state.isSelectHome
                                              ? Colors.white
                                              : Colors.grey,
                                          size: 11,
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          "address.home".tr(),
                                          style: context.textTheme.bodyMedium!
                                              .copyWith(
                                            color: state.isSelectHome
                                                ? Colors.white
                                                : Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 13,
                                ),
                                InkWell(
                                  onTap: () {
                                    addAddressCubit
                                        .changeSelectedLocationType(false);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 18.w),
                                    decoration: BoxDecoration(
                                      color: !state.isSelectHome
                                          ? AppMaterialColors.green.shade200
                                          : null,
                                      borderRadius: BorderRadius.circular(19),
                                      border: !state.isSelectHome
                                          ? null
                                          : Border.all(color: Colors.grey),
                                    ),
                                    child: Row(
                                      children: [
                                        CustomSvgIcon(
                                          Assets.icons.addressWorkIcon,
                                          color: !state.isSelectHome
                                              ? Colors.white
                                              : Colors.grey,
                                          size: 11,
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          "address.work".tr(),
                                          style: context.textTheme.bodyMedium!
                                              .copyWith(
                                            color: !state.isSelectHome
                                                ? Colors.white
                                                : Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            if (state.addressSelected != "")
                              Text(
                                state.addressSelected!,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            SizedBox(
                              height: 16.h,
                            ),
                            if (state.status == AddAddressStatus.error &&
                                state.addressFailure != null)
                              ErrorBanner(
                                failure: state.addressFailure!,
                              ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                child: CustomFormField(
                                  boarderRadius: 12.r,
                                  controller: state.addressNameTextController,
                                  autoValidate: state.autoValidate,
                                  validator:
                                      ValidationService.requiredFieldValidator,
                                  onChange:
                                      addAddressCubit.onAddressNameChanged,
                                  hintText: "address.address_name".tr(),
                                  prefixIcon: SizedBox(
                                    width: 5.w,
                                  ),
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.visiblePassword,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                child: CustomFormField(
                                  boarderRadius: 12.r,
                                  controller: state.buildingNameTextController,
                                  autoValidate: state.autoValidate,
                                  validator:
                                      ValidationService.requiredFieldValidator,
                                  onChange:
                                      addAddressCubit.onBuildingNameChanged,
                                  hintText: "address.building_name".tr(),
                                  prefixIcon: SizedBox(
                                    width: 5.w,
                                  ),
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.visiblePassword,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                child: CustomFormField(
                                  boarderRadius: 12.r,
                                  controller: state.apartmentTextController,
                                  autoValidate: state.autoValidate,
                                  validator:
                                      ValidationService.requiredFieldValidator,
                                  onChange:
                                      addAddressCubit.onApartmentNumberChanged,
                                  hintText: "address.apartment_office".tr(),
                                  prefixIcon: SizedBox(
                                    width: 5.w,
                                  ),
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.number,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                child: CustomFormField(
                                  boarderRadius: 12.r,
                                  controller: state.landMarkTextController,
                                  autoValidate: state.autoValidate,
                                  validator:
                                      ValidationService.requiredFieldValidator,
                                  onChange: addAddressCubit.onLandMarkChanged,
                                  hintText: "address.landmark".tr(),
                                  prefixIcon: SizedBox(
                                    width: 5.w,
                                  ),
                                  textInputAction: TextInputAction.done,
                                  textInputType: TextInputType.visiblePassword,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                child: CustomFormField(
                                  boarderRadius: 12.r,
                                  controller: state.googleInfoTextController,
                                  autoValidate: state.autoValidate,
                                  validator:
                                      ValidationService.requiredFieldValidator,
                                  onChange: addAddressCubit.onGoogleInfoChanged,
                                  hintText: "address.google_info".tr(),
                                  readOnly: state
                                      .googleInfoTextController.text.isEmpty,
                                  prefixIcon: SizedBox(
                                    width: 5.w,
                                  ),
                                  textInputAction: TextInputAction.done,
                                  textInputType: TextInputType.visiblePassword,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            state.status == AddAddressStatus.loading
                                ? const LoadingBanner()
                                : Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                                .padding
                                                .bottom +
                                            40.h),
                                    child: CustomButton(
                                      onTap: () {
                                        if (widget.addressModel != null) {
                                          addAddressCubit.submitAddress(
                                              update: true,
                                              address: widget.addressModel!);
                                        } else {
                                          addAddressCubit.submitAddress(
                                              update: false);
                                        }
                                      },
                                      width: 388.w,
                                      withGradient: true,
                                      child: Center(
                                        child: Text(
                                          "address.save_Continue".tr(),
                                          style: TextStyle(
                                              color: AppMaterialColors.white,
                                              fontSize: 14.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  placesAutoCompleteTextField() {
    return SizedBox(
      height: 80.h,
      child: Row(
        children: [
          Expanded(
            child: GooglePlaceAutoCompleteTextField(
              textEditingController: controller,
              googleAPIKey: "AIzaSyAM2lbvMzNPHIE5LiqgfjGRtaUs765L5RA",
              inputDecoration: InputDecoration(
                  hintText: "home_page.Search_location".tr(),
                  border: InputBorder.none,
                  suffixIcon: TextButton(
                    child: Text("address.clear".tr()),
                    onPressed: () {
                      controller.clear();
                      setState(() {});
                    },
                  )),
              debounceTime: 400,
              countries: const ["ae"],
              isLatLngRequired: true,
              getPlaceDetailWithLatLng: (Prediction prediction) {
                addAddressCubit.whenPressOnPlace(prediction);
              },
              itemClick: (Prediction prediction) {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus &&
                    currentFocus.focusedChild != null) {
                  FocusManager.instance.primaryFocus!.unfocus();
                }
                controller.text = prediction.description ?? "";
                controller.selection = TextSelection.fromPosition(
                    TextPosition(offset: prediction.description?.length ?? 0));
                // addAddressCubit.whenPressOnPlace(prediction);
              },
              seperatedBuilder: const SizedBox(),
              boxDecoration: const BoxDecoration(color: Colors.transparent),
              containerHorizontalPadding: 10,
              itemBuilder: (context, index, Prediction prediction) {
                return Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on),
                      SizedBox(
                        width: 5.w,
                      ),
                      Expanded(child: Text(prediction.description ?? ""))
                    ],
                  ),
                );
              },
              isCrossBtnShown: false,
            ),
          ),
          IconButton(
            onPressed: () {
              addAddressCubit.getLocation(true);
            },
            icon: const Icon(Icons.my_location),
          ),
        ],
      ),
    );
  }
}
