import 'package:dawaa24/core/data/model/base_response_model.dart';
import 'package:dawaa24/core/utils/constants.dart';
import 'package:dawaa24/features/order/data/model/order_details_model.dart';
import 'package:dawaa24/features/order/data/model/order_list_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/data/datasource/base_remote_datasource.dart';
import 'order_remote_datasource.dart';

@Singleton(as: OrderRemoteDataSource)
class OrderDataSourceImpl extends BaseRemoteDataSourceImpl
    implements OrderRemoteDataSource {
  OrderDataSourceImpl({required super.dio});

  String  getMyLatestOrderEndPoint=
      "${AppConstant.baseUrl}/api/app/orders/GetCurrentOrders";
  String getMyHistoricOrderEndPoint =
      "${AppConstant.baseUrl}/api/app/orders/GetHistoryOrders";
  String getOrderDetailsEndPoint =
      '${AppConstant.baseUrl}/api/app/orders/GetDetailsOfOrder';

  @override
  Future<BaseResponse<Page<OrderListModel>>> getMyHistoricOrder(
      Map<String, dynamic> params) async {
    final res = await get(
        url: getMyHistoricOrderEndPoint,
        params: params,
        decoder: (json) =>
            Page.fromJson(json, OrderListModel.fromJson, ListKeysPage.items),
        requiredToken: true);
    return res;
  }

  @override
  Future<BaseResponse<Page<OrderListModel>>> getMyLatestOrder(
      Map<String, dynamic> params) async {
    final res = await get(
        url: getMyLatestOrderEndPoint,
        params: params,
        decoder: (json) =>
            Page.fromJson(json, OrderListModel.fromJson, ListKeysPage.items),
        requiredToken: true);
    return res;
  }

  @override
  Future<BaseResponse<OrderDetailsModel>> getOrderDetails(
      String orderId) async {
    final res = await get(
        url: getOrderDetailsEndPoint,
        decoder: (json) => OrderDetailsModel.fromJson(json),
        params: {"orderId": orderId},
        requiredToken: true);

    return res;
  }

}
