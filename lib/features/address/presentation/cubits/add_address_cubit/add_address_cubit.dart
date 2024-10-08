import 'package:bloc/bloc.dart';
import 'package:dawaa24/di/injection.dart';
import 'package:dawaa24/features/address/data/model/address_model.dart';
import 'package:dawaa24/features/address/domain/usecase/add_address_usecase.dart';
import 'package:dawaa24/features/address/domain/usecase/update_address_usecase.dart';
import 'package:dawaa24/features/auth/presentation/cubits/authentication/authentication_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../../../core/services/location_helper.dart';
import '../../../../../core/utils/failures/base_failure.dart';
import '../../../domain/params/add_address_params.dart';
import 'package:google_places_flutter/model/prediction.dart';

part 'add_address_state.dart';

class AddAddressCubit extends Cubit<AddAddressState> {
  AddAddressCubit() : super(AddAddressState.initial()) {
    locationHelper = getIt<LocationHelper>();
    _addAddressUseCase = getIt<AddAddressUseCase>();
    _updateAddressUseCase = getIt<UpdateAddressUseCase>();
  }

  late AuthenticationCubit authenticationCubit;
  late AddAddressUseCase _addAddressUseCase;
  late UpdateAddressUseCase _updateAddressUseCase;
  late LocationHelper locationHelper;

  submitAddress({required bool update, AddressModel? address}) async {
    if (!(state.formKey?.currentState?.validate() ?? true) ||
        state.currentPosition == null) {
      emit(state.copyWith(autoValidate: true));
      if (state.currentPosition == null) {
        Fluttertoast.showToast(
            msg: "address.select_location".tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.sp);
      }
      return;
    }
    emit(state.changeState(AddAddressStatus.loading));
    try {
      update
          ? await _updateAddressUseCase(state.addAddressParams!.copyWith(
              name: state.addressNameTextController.text,
              buildingName: state.buildingNameTextController.text,
              apartmentNumber: state.apartmentTextController.text,
              landmark: state.landMarkTextController.text,
              id: address!.id,
              longitude: state.currentPosition!.longitude.toString(),
              latitude: state.currentPosition!.latitude.toString(),
              isDefault: address.isDefault))
          : await _addAddressUseCase(state.addAddressParams!);
      emit(state.changeState(AddAddressStatus.success));
    } on Failure catch (l) {
      emit(state.addressError(l));
    }
  }

  setGoogleMapController(GoogleMapController controller) {
    emit(state.copyWith(googleMapController: controller));
  }

  changeSelectedLocationType(bool isSelectHome) {
    emit(state.copyWith(
        isSelectHome: isSelectHome,
        params: state.addAddressParams!.copyWith(type: isSelectHome ? 0 : 1)));
  }

  moveCamera(LatLng newLatLng) {
    if (state.currentPosition != null) {
      state.googleMapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
            LatLng(
              newLatLng.latitude,
              newLatLng.longitude,
            ),
            13),
      );
    }
  }

  onMoveLocation(CameraPosition position) async {
    emit(state.copyWith(currentPosition: position.target));
  }

  getLocation(bool manually) async {
    if (manually) {
      var location = await locationHelper.getLocation();
      if (location != null) {
        onMoveLocation(CameraPosition(
            target: LatLng(location.latitude!, location.longitude!)));
        moveCamera(LatLng(location.latitude!, location.longitude!));
        getLocationDesc(
            state.currentPosition!.latitude, state.currentPosition!.longitude);
      }
    }
  }

  getLocationDescFiled() {
    getLocationDesc(
        state.currentPosition!.latitude, state.currentPosition!.longitude);
  }

  whenPressOnPlace(Prediction prediction) {
    emit(state.copyWith(
        currentPosition: LatLng(
            double.parse(prediction.lat!), double.parse(prediction.lng!))));

    moveCamera(
        LatLng(double.parse(prediction.lat!), double.parse(prediction.lng!)));
  }

  getLocationDesc(double lat, double long) async {
    final result =
        await locationHelper.getLocationAddressFromLatLng(lat: lat, long: long);
    onGoogleMapsDescriptionChanged(
        '${result.country}-${result.administrativeArea}-${result.street}-${result.name}',
        '${result.country}-${result.administrativeArea}');
    emit(state.copyWith(
        params: state.addAddressParams!
            .copyWith(latitude: lat.toString(), longitude: long.toString())));
  }

  onGoogleMapsDescriptionChanged(String value, String address) {
    onGoogleInfoChanged(value);
  }

  onLatLngChanged(double lat, double long) {
    emit(state.copyWith(
        params: state.addAddressParams!
            .copyWith(latitude: lat.toString(), longitude: long.toString())));
  }

  onAddressNameChanged(String value) {
    emit(state.copyWith(params: state.addAddressParams!.copyWith(name: value)));
  }

  onGoogleInfoChanged(String value) {
    emit(state.copyWith(
        params: state.addAddressParams!.copyWith(address: value),
        googleInfo: value));
  }

  onBuildingNameChanged(String value) {
    emit(state.copyWith(
        params: state.addAddressParams!.copyWith(buildingName: value)));
  }

  onApartmentNumberChanged(String value) {
    emit(state.copyWith(
        params: state.addAddressParams!.copyWith(apartmentNumber: value)));
  }

  onLandMarkChanged(String value) {
    emit(state.copyWith(
        params: state.addAddressParams!.copyWith(landmark: value)));
  }

  onAddressTypeChanged(int value) {
    emit(state.copyWith(
        params: state.addAddressParams!
            .copyWith(apartmentNumber: value.toString())));
  }

  fillEditMode(AddressModel addressModel) {
    emit(state.copyWith(
      addressName: addressModel.name,
      buildingName: addressModel.buildingName,
      apartmentNo: addressModel.apartmentNumber,
      landMark: addressModel.landmark,
      googleInfo: addressModel.address,
      currentPosition: LatLng(addressModel.latitude!, addressModel.longitude!),
      isSelectHome: addressModel.type == 1 ? true : false,
    ));
  }
}
