// [1:OTC,2:scanning,3:refill,5:All]
import 'package:dawaa24/core/utils/extentions.dart';

enum OrderType { _, otc, scanning, refill, all }

Map<String, OrderType> stringToEnumOrderType = {
  "All": OrderType.all,
  "OTC": OrderType.otc,
  "Refill": OrderType.refill,
};

Map<OrderType, String> enumToStringOrderType =
    stringToEnumOrderType.inverse<OrderType, String>();

extension OrderTypeExtension on String {
  OrderType stringToEnum() {
    return stringToEnumOrderType[this]!;
  }
}

extension OrderTypeExtensionOnString on OrderType {
  String enumToString() {
    return enumToStringOrderType[this]!;
  }
}
