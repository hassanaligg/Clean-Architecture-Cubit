import 'package:dawaa24/features/order/data/model/order_details_model.dart';

import '../../../../core/data/model/base_response_model.dart';
import '../../data/model/order_list_model.dart';

abstract class OrderRepository {
  Future<Page<OrderListModel>> getMyLatestOrder(Map<String, dynamic> params);

  Future<Page<OrderListModel>> getMyHistoricOrder(Map<String, dynamic> params);

  Future<OrderDetailsModel> getOrderDetails(String orderId);

}
