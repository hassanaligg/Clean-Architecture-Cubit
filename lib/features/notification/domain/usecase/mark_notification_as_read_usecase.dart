import 'package:dawaa24/features/notification/domain/repository/notification_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/domain/usecase/usecase.dart';

@injectable
class MarkNotificationAsReadUseCase extends UseCase<bool, String> {
  final NotificationRepository repository;

  MarkNotificationAsReadUseCase({required this.repository});

  @override
  Future<bool> call(params) async {
    return repository.markNotificationAsRead({'NotificationId': params});
  }
}
