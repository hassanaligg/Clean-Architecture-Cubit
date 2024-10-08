import 'package:bloc/bloc.dart';
import 'package:dawaa24/features/address/domain/params/get_address_list_params.dart';
import 'package:dawaa24/features/address/domain/usecase/delete_address_usecase.dart';
import 'package:dawaa24/features/address/domain/usecase/get_address_usecase.dart';
import 'package:dawaa24/features/address/domain/usecase/make_default_address_usecase.dart';

import '../../../../../core/services/location_helper.dart';
import '../../../../../core/services/pagination_service/pagination_cubit.dart';
import '../../../../../core/utils/failures/base_failure.dart';
import '../../../../../di/injection.dart';
import '../../../data/model/address_model.dart';
import 'address_list_state.dart';

class AddressListCubit extends Cubit<AddressListState> {
  late LocationHelper locationHelper;

  AddressListCubit() : super(AddressListState.initial()) {
    _getAddressListUseCase = getIt<GetAddressListUseCase>();
    _makeAddressDefaultUseCase = getIt<MakeAddressDefaultUseCase>();
    _deleteAddressUseCase = getIt<DeleteAddressUseCase>();
    getAddressList();
  }

  late GetAddressListUseCase _getAddressListUseCase;
  late MakeAddressDefaultUseCase _makeAddressDefaultUseCase;
  late DeleteAddressUseCase _deleteAddressUseCase;
  late PaginationCubit<AddressModel> paginationCubit;

  getAddressList() {
    paginationCubit =
        PaginationCubit(loadPage: (int currentPage, int maxResult) {
      GetAddressListParams getAddressListParams = GetAddressListParams(
          maxResultCount: maxResult, skipCount: currentPage);
      var res = _getAddressListUseCase(getAddressListParams);
      return res;
    });
  }

  makeAddressDefault(String addressId) async {
    emit(state.copyWith(status: AddressListStatus.loading));
    try {
      await _makeAddressDefaultUseCase(addressId);
      emit(state.copyWith(status: AddressListStatus.updated));
      getAddressList();
    } on Failure catch (l) {
      emit(state.addressError(l));
    }
  }

  deleteAddress(String addressId) async {
    emit(state.copyWith(status: AddressListStatus.loading));
    try {
      await _deleteAddressUseCase(addressId);
      emit(state.copyWith(status: AddressListStatus.deleted));
      getAddressList();
    } on Failure catch (l) {
      emit(state.addressError(l));
    }
  }

  refreshAddressList() {
    getAddressList();
  }
}
