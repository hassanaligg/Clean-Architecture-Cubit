import 'package:bloc/bloc.dart';
import 'package:dawaa24/core/utils/failures/base_failure.dart';
import 'package:dawaa24/features/pharmacies/data/model/pharmacie_model.dart';
import 'package:dawaa24/features/pharmacies/domain/usecase/add_to_my_pharmacy_usecase.dart';
import 'package:dawaa24/features/pharmacies/domain/usecase/get_pharmacy_details_usecase.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../di/injection.dart';
import '../../../data/model/working_time_model.dart';

part 'pharmacy_details_state.dart';

class PharmacyDetailsCubit extends Cubit<PharmacyDetailsState> {
  PharmacyDetailsCubit() : super(PharmacyDetailsState.initial()) {
    _getPharmacyDetailsUseCase = getIt<GetPharmacyDetailsUseCase>();
    _addToMyPharmacyUseCase = getIt<AddToMyPharmacyUseCase>();
  }

  late GetPharmacyDetailsUseCase _getPharmacyDetailsUseCase;
  late AddToMyPharmacyUseCase _addToMyPharmacyUseCase;

  getPharmacyDetails(String pharmacyId) async {
    emit(state.copyWith(status: PharmacyDetailsStatus.loading));
    try {
      var pharmacyModel = await _getPharmacyDetailsUseCase(pharmacyId);
      emit(state.copyWith(
          status: PharmacyDetailsStatus.success, pharmacyModel: pharmacyModel));
    } on Failure catch (e) {
      emit(state.copyWith(failure: e, status: PharmacyDetailsStatus.error));
    }
  }

  Future<String?> addToMyPharmacy(String pharmacyId) async {
    emit(state.copyWith(status: PharmacyDetailsStatus.addToMyPharmacyLoading));
    try {
      var addToMyPharmacyMessage = await _addToMyPharmacyUseCase(pharmacyId);
      emit(state.copyWith(status: PharmacyDetailsStatus.success));
      return addToMyPharmacyMessage;
    } on Failure catch (e) {
      emit(state.copyWith(
          addToMyPharmacyFailure: e,
          status: PharmacyDetailsStatus.addToMyPharmacyError));
    }
    return null;
  }

  fillPharmacyDetails(PharmacyModel pharmacyModel) {
    emit(state.copyWith(pharmacyModel: pharmacyModel));
  }

  String getSlotDate(WorkingTimeModel workingTimeModel, String locale) {
    DateTime currentDateTime = DateTime.now();
    DateTime currentTime = currentDateTime.toLocal();

    int workingDay = workingTimeModel.workDay == 0 ? DateTime.sunday : workingTimeModel.workDay;

    if (workingTimeModel.is24Hours) {
      return is24Hour(workingDay, locale);
    }

    DateFormat timeFormat = DateFormat("HH:mm", "en");
    DateTime fromParsed = timeFormat.parse(workingTimeModel.from);
    DateTime toParsed = timeFormat.parse(workingTimeModel.to);

    DateTime nextWeekday(DateTime startDate, int weekday) {
      while (startDate.weekday != weekday) {
        startDate = startDate.add(Duration(days: 1));
      }
      return startDate;
    }

    DateTime nextWorkingDay = nextWeekday(currentTime, workingDay);

    DateTime fromTime = DateTime(
      nextWorkingDay.year,
      nextWorkingDay.month,
      nextWorkingDay.day,
      fromParsed.hour,
      fromParsed.minute,
    );

    DateTime toTime = DateTime(
      nextWorkingDay.year,
      nextWorkingDay.month,
      nextWorkingDay.day,
      toParsed.hour,
      toParsed.minute,
    );

    DateFormat fromFormat = DateFormat("EEEE", locale);
    return fromFormat.format(fromTime);
  }
  String getSlotTime(WorkingTimeModel workingTimeModel, String locale) {
    DateTime currentDateTime = DateTime.now();
    DateTime currentTime = currentDateTime.toLocal();

    int workingDay = workingTimeModel.workDay == 0 ? DateTime.sunday : workingTimeModel.workDay;

    if (workingTimeModel.is24Hours) {
      return is24Hour(workingDay, locale);
    }

    DateFormat timeFormat = DateFormat("HH:mm", "en");
    DateTime fromParsed = timeFormat.parse(workingTimeModel.from);
    DateTime toParsed = timeFormat.parse(workingTimeModel.to);

    DateTime nextWeekday(DateTime startDate, int weekday) {
      while (startDate.weekday != weekday) {
        startDate = startDate.add(Duration(days: 1));
      }
      return startDate;
    }

    DateTime nextWorkingDay = nextWeekday(currentTime, workingDay);

    DateTime fromTime = DateTime(
      nextWorkingDay.year,
      nextWorkingDay.month,
      nextWorkingDay.day,
      fromParsed.hour,
      fromParsed.minute,
    );

    DateTime toTime = DateTime(
      nextWorkingDay.year,
      nextWorkingDay.month,
      nextWorkingDay.day,
      toParsed.hour,
      toParsed.minute,
    );

    DateFormat fromFormat = DateFormat("hh:mm a", locale);
    DateFormat toFormat = DateFormat("hh:mm a", locale);
    return "${fromFormat.format(fromTime)}-${toFormat.format(toTime)}";
  }


  is24Hour(int workDay, local) {
    DateTime dateTime =
        DateTime.now().subtract(Duration(days: DateTime.now().weekday));
    dateTime = dateTime.add(Duration(days: workDay ));

    return DateFormat('EEEE', local).format(dateTime);
  }
}
