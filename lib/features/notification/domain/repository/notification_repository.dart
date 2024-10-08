import 'package:dawaa24/features/notification/data/model/notification_model.dart';

import '../../../../core/data/model/base_response_model.dart';

abstract class NotificationRepository {
  Future<Page<NotificationModel>> getMyNotificationsList(
      Map<String, dynamic> params);
  Future<bool> markNotificationAsRead(
      Map<String, dynamic> params);
}
