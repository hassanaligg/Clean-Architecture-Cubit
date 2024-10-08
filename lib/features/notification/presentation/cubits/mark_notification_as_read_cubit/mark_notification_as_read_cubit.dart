import 'package:bloc/bloc.dart';
import 'package:dawaa24/core/utils/failures/base_failure.dart';
import 'package:dawaa24/features/notification/domain/usecase/mark_notification_as_read_usecase.dart';

import '../../../../../di/injection.dart';

part 'mark_notification_as_read_state.dart';

class MarkNotificationAsReadCubit extends Cubit<MarkNotificationAsReadState> {
  MarkNotificationAsReadCubit() : super(MarkNotificationAsReadState.initial()) {
    _markNotificationAsReadUseCase = getIt<MarkNotificationAsReadUseCase>();
  }

  late MarkNotificationAsReadUseCase _markNotificationAsReadUseCase;

  Future<bool> markNotification(String id) async {
    try {
      emit(state.copyWith(status: MarkNotificationAsReadStatus.loading));
      await _markNotificationAsReadUseCase(id);
      emit(state.copyWith(
        status: MarkNotificationAsReadStatus.success,
      ));
      return Future.value(true);
    } on Failure catch (l) {
      emit(
        state.copyWith(
          failure: l,
          status: MarkNotificationAsReadStatus.error,
        ),
      );
      print("najati result is::$l");
      return Future.value(false);
    }
  }
}
