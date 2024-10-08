import 'package:dawaa24/core/data/model/base_response_model.dart';
import 'package:dawaa24/core/utils/constants.dart';
import 'package:dawaa24/features/notification/data/model/notification_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/data/datasource/base_remote_datasource.dart';
import 'notification_remote_datasource.dart';

@Singleton(as: NotificationRemoteDataSource)
class NotificationDataSourceImpl extends BaseRemoteDataSourceImpl
    implements NotificationRemoteDataSource {
  NotificationDataSourceImpl({required super.dio});

  String getMyNotificationsListEndPoint =
      "${AppConstant.baseUrl}/api/app/notifications/GetUserNotifications";
  String markAsReadEndPoint =
      "${AppConstant.baseUrl}/api/app/notifications/MarkAsRead";

  @override
  Future<BaseResponse<Page<NotificationModel>>> getMyNotificationsList(
      Map<String, dynamic> params) async {
    final res = await get(
        url: getMyNotificationsListEndPoint,
        params: params,
        decoder: (json) =>
            Page.fromJson(json, NotificationModel.fromJson, ListKeysPage.items),
        requiredToken: true);
    return res;
  }

  @override
  Future<BaseResponse> markNotificationAsRead(
      Map<String, dynamic> params) async {
    final res = await put(
        url: markAsReadEndPoint,
        params: params,
        decoder: (json) {},
        requiredToken: true);
    return res;
  }
}
