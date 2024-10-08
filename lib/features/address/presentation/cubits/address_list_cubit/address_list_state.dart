import '../../../../../core/utils/failures/base_failure.dart';
import '../../../data/model/address_model.dart';

enum AddressListStatus { initial, loading, error, success,updated,deleted }

class AddressListState {
  final AddressListStatus status;
  final Failure? addressFailure;
  final List<AddressModel> addressList;

  AddressListState._({
    required this.status,
    this.addressFailure,
    required this.addressList,
  });

  AddressListState.initial()
      : status = AddressListStatus.initial,
        addressFailure = null,
        addressList = [];

  AddressListState addressError(Failure failure) {
    return copyWith(status: AddressListStatus.error, addressFailure: failure);
  }

  copyWith(
      {AddressListStatus? status,
      Failure? addressFailure,
      List<AddressModel>? addressList}) {
    return AddressListState._(
      status: status ?? this.status,
      addressFailure: addressFailure ?? this.addressFailure,
      addressList: addressList ?? this.addressList,
    );
  }
}
