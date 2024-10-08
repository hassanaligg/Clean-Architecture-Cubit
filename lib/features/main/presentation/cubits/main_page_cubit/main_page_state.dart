import '../../../../../core/utils/failures/base_failure.dart';
import '../../../../auth/data/model/profile_model.dart';

enum MainPageStatus { initial, loading, error, success, refresh }

class MainPageState {
  final MainPageStatus status;
  final Failure? mainPageFailure;
  final ProfileModel? profileModel;

  MainPageState._({
    required this.status,
    this.mainPageFailure,
    this.profileModel,
  });

  MainPageState.initial()
      : status = MainPageStatus.initial,
        profileModel = null,
        mainPageFailure = null;

  copyWith({
    MainPageStatus? status,
    Failure? mainPageFailure,
    ProfileModel? profileModel,
  }) {
    return MainPageState._(
      status: status ?? this.status,
      mainPageFailure: mainPageFailure ?? this.mainPageFailure,
      profileModel: profileModel ?? this.profileModel,
    );
  }
}
