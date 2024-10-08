// import 'package:dawaa24/features/cart/data/model/cart_item.dart';
//
// class DataBaseConfig {
//   static const String notificationTableName = "notifications";
//   static const String cartTableName = "cart";
//   static const int dataBaseVersion = 9;
//
//   static Map<String, String> createTableCommands = {
//     notificationTableName: """
//   CREATE TABLE $notificationTableName(
//   providerProductId    INTEGER  NOT NULL PRIMARY KEY
//   ,isDrug               VARCHAR(5) NOT NULL
//   ,tradeName            VARCHAR(29) NOT NULL
//   ,categoryId           INTEGER  NOT NULL
//   ,providerId           INTEGER  NOT NULL
//   ,providerName         VARCHAR(16) NOT NULL
//   ,providerProductPrice NUMERIC(5,2) NOT NULL
//   ,currencyName         VARCHAR(3) NOT NULL
//   ,availalbeQuantity    INTEGER  NOT NULL
//   ,categoryName         VARCHAR(14) NOT NULL
//   ,favoriteId           BIT  NOT NULL
//   ,isFavorite           VARCHAR(5) NOT NULL
//   ,productImage         VARCHAR(83) NOT NULL
//   ,miles                NUMERIC(18,15) NOT NULL
//   );""",
//     cartTableName: """
//   CREATE TABLE $cartTableName(
//   ${CartItemKeys.providerDrugId}    INTEGER  NOT NULL PRIMARY KEY
//   ,${CartItemKeys.providerId}         INTEGER  NOT NULL
//   ,${CartItemKeys.quantity}         INTEGER  NOT NULL
//   ,${CartItemKeys.price}         NUMERIC(5,2) NOT NULL
//   ,${CartItemKeys.picturePath}        VARCHAR(83)
//   ,${CartItemKeys.providerName}       VARCHAR(16) NOT NULL
//   ,${CartItemKeys.drugTradeName}            VARCHAR(29) NOT NULL
//   ,${CartItemKeys.isDrug}         INTEGER  NOT NULL
//   ,${CartItemKeys.availalbeQuantity}    INTEGER  NOT NULL
//   ,${CartItemKeys.userId} VARCHAR(20)
//   ,${CartItemKeys.drugPrice} NUMERIC(5,2) NOT NULL
//   );""",
//   };
//
//   static List<String> getAllTablesNames() {
//     return createTableCommands.keys.toList();
//   }
// }
