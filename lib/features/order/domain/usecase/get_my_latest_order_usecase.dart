import 'package:dawaa24/core/data/model/base_response_model.dart';
import 'package:dawaa24/features/order/data/model/order_list_model.dart';
import 'package:dawaa24/features/order/domain/params/get_my_orders_params_model.dart';
import 'package:dawaa24/features/order/domain/repository/order_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/domain/usecase/usecase.dart';

@injectable
class GetMyLatestUseCase
    extends UseCase<Page<OrderListModel>, GetMyOrdersParamsModel> {
  final OrderRepository repository;

  GetMyLatestUseCase({required this.repository});

  @override
  Future<Page<OrderListModel>> call(params) async {
    return repository.getMyLatestOrder(params.toJson());
  }
}
