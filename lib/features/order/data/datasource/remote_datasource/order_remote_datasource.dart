import 'package:dawaa24/features/order/data/model/order_details_model.dart';
import 'package:dawaa24/features/order/data/model/order_list_model.dart';

import '../../../../../core/data/model/base_response_model.dart';

abstract class OrderRemoteDataSource {
  Future<BaseResponse<Page<OrderListModel>>> getMyLatestOrder(
      Map<String, dynamic> params);

  Future<BaseResponse<Page<OrderListModel>>> getMyHistoricOrder(
      Map<String, dynamic> params);

  Future<BaseResponse<OrderDetailsModel>> getOrderDetails(String orderId);
}
