import 'package:dawaa24/core/domain/usecase/usecase.dart';
import 'package:dawaa24/features/order/data/model/order_details_model.dart';
import 'package:dawaa24/features/order/domain/repository/order_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOrderDetailsUseCase extends UseCase<OrderDetailsModel, String> {
  final OrderRepository repository;

  GetOrderDetailsUseCase({required this.repository});

  @override
  Future<OrderDetailsModel> call(params) async {
    return repository.getOrderDetails(params);
  }
}
