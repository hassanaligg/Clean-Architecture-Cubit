import '../../../../core/data/enums/order_list_status_enum.dart';
import '../../../../core/data/enums/order_list_type_enum.dart';

class OrderListModel {
  OrderListModel({
    required this.id,
    required this.pharmacyName,
    required this.pharmacyId,
    required this.orderId,
    required this.total,
    required this.currency,
    required this.orderType,
    required this.orderStatus,
    required this.createdOn,
  });

  final String? id;
  final String? pharmacyName;
  final String? pharmacyId;
  final String? orderId;
  final String? total;
  final String? currency;
  final OrderLisTypeEnum? orderType;
  final OrderListStatusEnum? orderStatus;
  final double? createdOn;

  OrderListModel copyWith({
    String? id,
    String? pharmacyName,
    String? pharmacyId,
    String? orderId,
    String? total,
    String? currency,
    OrderLisTypeEnum? orderType,
    OrderListStatusEnum? orderStatus,
    double? createdOn,
  }) {
    return OrderListModel(
      id: id ?? this.id,
      pharmacyName: pharmacyName ?? this.pharmacyName,
      pharmacyId: pharmacyId ?? this.pharmacyId,
      orderId: orderId ?? this.orderId,
      total: total ?? this.total,
      currency: currency ?? this.currency,
      orderType: orderType ?? this.orderType,
      orderStatus: orderStatus ?? this.orderStatus,
      createdOn: createdOn ?? this.createdOn,
    );
  }

  factory OrderListModel.fromJson(Map<String, dynamic> json) {
    return OrderListModel(
      id: json["id"],
      pharmacyName: json["pharmacyName"],
      pharmacyId: json["pharmacyId"],
      orderId: json["orderId"],
      total: json["total"],
      currency: json["currency"],
      orderType: (json['orderType'] == 0)
          ? OrderLisTypeEnum.delivery
          : (json['orderType'] == 1)
              ? OrderLisTypeEnum.pickUp
              : OrderLisTypeEnum.unKnown,
      orderStatus: (json['orderStatus'] == 0)
          ? OrderListStatusEnum.pending
          : (json['orderStatus'] == 1)
              ? OrderListStatusEnum.outForDelivery
              : (json['orderStatus'] == 2)
                  ? OrderListStatusEnum.readyForPickup
                  : (json['orderStatus'] == 3)
                      ? OrderListStatusEnum.delivered
                      : (json['orderStatus'] == 4)
                          ? OrderListStatusEnum.returned
                          : (json['orderStatus'] == 5)
                              ? OrderListStatusEnum.cancelled
                              : OrderListStatusEnum.unKnown,
      createdOn: json["createdOn"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "pharmacyName": pharmacyName,
        "orderId": orderId,
        "total": total,
        "currency": currency,
        "orderType": orderType,
        "orderStatus": orderStatus,
        "createdOn": createdOn,
      };

  @override
  String toString() {
    return "$id, $pharmacyName, $orderId, $total, $currency, $orderType, $orderStatus, $createdOn, ";
  }
}
