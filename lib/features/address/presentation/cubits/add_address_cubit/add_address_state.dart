part of 'add_address_cubit.dart';

enum AddAddressStatus { initial, loading, error, success }

class AddAddressState {
  final AddAddressStatus status;
  final Failure? addressFailure;
  final bool autoValidate;
  final DraggableScrollableController draggableScrollableController;

  TextEditingController addressNameTextController;
  TextEditingController buildingNameTextController;
  TextEditingController apartmentTextController;
  TextEditingController landMarkTextController;
  TextEditingController googleInfoTextController;
  GoogleMapController? googleMapController;
  LocationData? locationData;
  GlobalKey<FormState>? formKey;
  LatLng? currentPosition;

  bool isSelectHome;

  String? addressSelected;
  AddAddressParams? addAddressParams;

  AddAddressState._({
    required this.status,
    this.addressFailure,
    this.currentPosition,
    required this.isSelectHome,
    this.googleMapController,
    required this.draggableScrollableController,
    this.locationData,
    required this.autoValidate,
    required this.addAddressParams,
    required this.addressNameTextController,
    required this.buildingNameTextController,
    required this.apartmentTextController,
    required this.landMarkTextController,
    required this.googleInfoTextController,
    required this.addressSelected,
    this.formKey,
  });

  AddAddressState.initial()
      : status = AddAddressStatus.initial,
        addressFailure = null,
        autoValidate = false,
        formKey = GlobalKey(),
        isSelectHome = true,
        draggableScrollableController = DraggableScrollableController(),
        currentPosition = const LatLng(25.2048, 55.2708),
        addressSelected = "",
        addAddressParams = AddAddressParams.empty(),
        addressNameTextController = TextEditingController(),
        buildingNameTextController = TextEditingController(),
        landMarkTextController = TextEditingController(),
        googleInfoTextController = TextEditingController(),
        apartmentTextController = TextEditingController();

  AddAddressState changeState(AddAddressStatus status) {
    return copyWith(status: status);
  }

  AddAddressState addressError(Failure failure) {
    return copyWith(status: AddAddressStatus.error, addressFailure: failure);
  }

  copyWith({
    AddAddressStatus? status,
    Failure? addressFailure,
    GoogleMapController? googleMapController,
    LocationData? locationData,
    bool? autoValidate,
    bool? isSelectHome,
    String? addressName,
    String? buildingName,
    String? apartmentNo,
    String? landMark,
    String? googleInfo,
    String? addressSelected,
    AddAddressParams? params,
    LatLng? currentPosition,
  }) {
    if (addressName != null) {
      addressNameTextController.text = addressName;
    }
    if (buildingName != null) {
      buildingNameTextController.text = buildingName;
    }
    if (apartmentNo != null) {
      apartmentTextController.text = apartmentNo;
    }
    if (landMark != null) {
      landMarkTextController.text = landMark;
    }
    if (googleInfo != null) {
      googleInfoTextController.text = googleInfo;
    }
    return AddAddressState._(
      status: status ?? this.status,
      addressFailure: addressFailure ?? this.addressFailure,
      draggableScrollableController: draggableScrollableController,
      isSelectHome: isSelectHome ?? this.isSelectHome,
      currentPosition: currentPosition ?? this.currentPosition,
      googleMapController: googleMapController ?? this.googleMapController,
      locationData: locationData ?? this.locationData,
      autoValidate: autoValidate ?? this.autoValidate,
      addressSelected: addressSelected ?? this.addressSelected,
      addAddressParams: params ?? addAddressParams,
      formKey: formKey,
      addressNameTextController: addressNameTextController,
      buildingNameTextController: buildingNameTextController,
      apartmentTextController: apartmentTextController,
      landMarkTextController: landMarkTextController,
      googleInfoTextController: googleInfoTextController,
    );
  }
}
