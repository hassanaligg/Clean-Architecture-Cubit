import 'package:dawaa24/core/data/model/base_response_model.dart';
import 'package:dawaa24/features/order/data/datasource/remote_datasource/order_remote_datasource.dart';
import 'package:dawaa24/features/order/data/model/order_details_model.dart';
import 'package:dawaa24/features/order/data/model/order_list_model.dart';
import 'package:dawaa24/features/order/domain/repository/order_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: OrderRepository)
class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<OrderDetailsModel> getOrderDetails(String orderId) async {
    final res = await remoteDataSource.getOrderDetails(orderId);
    return res.data!;
  }

  @override
  Future<Page<OrderListModel>> getMyHistoricOrder(params) async {
    final res = await remoteDataSource.getMyHistoricOrder(params);
    return res.data!;
  }

  @override
  Future<Page<OrderListModel>> getMyLatestOrder(
      Map<String, dynamic> params) async {
    final res = await remoteDataSource.getMyLatestOrder(params);
    return res.data!;
  }
}
