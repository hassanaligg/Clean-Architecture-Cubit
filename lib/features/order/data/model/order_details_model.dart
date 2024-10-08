import 'package:dawaa24/core/data/enums/product_type_enum.dart';

import '../../../../core/data/enums/order_list_status_enum.dart';
import '../../../../core/data/enums/order_list_type_enum.dart';
import '../../../../core/data/enums/payment_method_enum.dart';

class OrderDetailsModel {
  String? id;
  String? pharmacyName;
  String? pharmacyAddress;
  double? pharmacyLatitude;
  double? pharmacyLongitude;
  String? pharmacyId;
  double? createdOn;
  String? orderId;
  OrderLisTypeEnum? orderType;
  OrderListStatusEnum? orderStatus;
  PaymentStatusEnum? paymentMethod;
  double? deliveryDate;
  PatientAddressDto? patientAddressDto;
  String? total;
  String? deliveryCost;
  String? reason;
  String? note;
  List<ProductModel>? items;

  OrderDetailsModel(
      {this.id,
      this.pharmacyName,
      this.pharmacyAddress,
      this.pharmacyLatitude,
      this.pharmacyLongitude,
      this.pharmacyId,
      this.createdOn,
      this.orderId,
      this.orderType,
      this.orderStatus,
      this.paymentMethod,
      this.deliveryDate,
      this.patientAddressDto,
      this.total,
      this.deliveryCost,
      this.reason,
      this.note,
      this.items});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pharmacyName = json['pharmacyName'];
    pharmacyAddress = json['pharmacyAddress'];
    pharmacyLatitude = json['pharmacyLatitude'];
    pharmacyLongitude = json['pharmacyLongitude'];
    pharmacyId = json['pharmacyId'];
    createdOn = json['createdOn'];
    orderId = json['orderId'];
    orderType = (json['orderType'] == 0)
        ? OrderLisTypeEnum.delivery
        : (json['orderType'] == 1)
            ? OrderLisTypeEnum.pickUp
            : OrderLisTypeEnum.unKnown;
    orderStatus = (json['orderStatus'] == 0)
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
                            : OrderListStatusEnum.unKnown;

    paymentMethod = (json['paymentMethod'] == 0)
        ? PaymentStatusEnum.cash
        : (json['paymentMethod'] == 1)
            ? PaymentStatusEnum.creditCard
            : PaymentStatusEnum.unKnown;
    deliveryDate = json['deliveryDate'];
    patientAddressDto = json['patientAddressDto'] != null
        ? PatientAddressDto.fromJson(json['patientAddressDto'])
        : null;
    total = json['total'];
    deliveryCost = json['deliveryCost']??"0.00";
    reason = json['reason'];
    note = json['note'];
    if (json['items'] != null) {
      items = <ProductModel>[];
      json['items'].forEach((v) {
        items!.add(ProductModel.fromJson(v));
      });
    }
  }
}

class PatientAddressDto {
  String? name;
  String? buildingName;
  String? appartmentNumber;
  String? landmark;
  double? longitude;
  double? latitude;
  String? address;
  int? type;
  bool? isDefault;
  String? id;

  PatientAddressDto(
      {this.name,
      this.buildingName,
      this.appartmentNumber,
      this.landmark,
      this.longitude,
      this.latitude,
      this.address,
      this.type,
      this.isDefault,
      this.id});

  PatientAddressDto.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    buildingName = json['buildingName'];
    appartmentNumber = json['appartmentNumber'];
    landmark = json['landmark'];
    longitude = json['longitude'].toDouble();
    latitude = json['latitude'].toDouble();
    address = json['address'];
    type = json['type'];
    isDefault = json['isDefault'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['buildingName'] = buildingName;
    data['appartmentNumber'] = appartmentNumber;
    data['landmark'] = landmark;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['address'] = address;
    data['type'] = type;
    data['isDefault'] = isDefault;
    data['id'] = id;
    return data;
  }
}

class ProductModel {
  String? id;
  String? name;
  int? quantity;
  ProductTypeEnum? type;
  String? price;
  String? image;
  String? orderId;
  String? categoryName;
  String? instruction;
  bool? isOtc;

  ProductModel(
      {this.id,
      this.name,
      this.type,
      this.quantity,
      this.price,
      this.image,
      this.orderId,
      this.isOtc,
      this.categoryName,
      this.instruction});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    type = (json['type'] == 0)
        ? ProductTypeEnum.drug
        : (json['type'] == 1)
            ? ProductTypeEnum.product
            : ProductTypeEnum.unKnown;
    image = json['image'];
    orderId = json['orderId'];
    categoryName = json['categoryName'];
    isOtc = json['isOTC'] ?? false;
    instruction = json['instruction'];
  }

}
