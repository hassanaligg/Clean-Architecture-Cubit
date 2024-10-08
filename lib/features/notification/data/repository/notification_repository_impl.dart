import 'package:dawaa24/core/data/model/base_response_model.dart';
import 'package:dawaa24/features/notification/data/datasource/remote_datasource/notification_remote_datasource.dart';
import 'package:dawaa24/features/notification/data/model/notification_model.dart';
import 'package:dawaa24/features/notification/domain/repository/notification_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<Page<NotificationModel>> getMyNotificationsList(
      Map<String, dynamic> params) async {
    final res = await remoteDataSource.getMyNotificationsList(params);
    return res.data!;
  }

  @override
  Future<bool> markNotificationAsRead(Map<String, dynamic> params) async {
    final res = await remoteDataSource.markNotificationAsRead(params);
    return res.status ?? false;
  }
}
