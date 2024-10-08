import 'package:dawaa24/core/data/model/base_response_model.dart';
import 'package:dawaa24/features/notification/data/model/notification_model.dart';
import 'package:dawaa24/features/notification/domain/repository/notification_repository.dart';
import 'package:dawaa24/features/order/domain/params/get_my_orders_params_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/domain/usecase/usecase.dart';

@injectable
class GetMyNotificationListUseCase
    extends UseCase<Page<NotificationModel>, GetMyOrdersParamsModel> {
  final NotificationRepository repository;

  GetMyNotificationListUseCase({required this.repository});

  @override
  Future<Page<NotificationModel>> call(params) async {
    return repository.getMyNotificationsList(params.toJson());
  }
}
