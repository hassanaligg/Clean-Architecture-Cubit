// import 'package:dawaa24/core/utils/database_config.dart';
// import 'package:dawaa24/features/cart/data/model/cart_item.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// import '../model/storable.dart';
//
// abstract class BaseCollectionDatasource {
//   Future<List<T>> getAll<T extends Storable>(
//       String collectionName, T Function(Map<String, dynamic> map) decoder);
//
//   Future<bool> storeItem<T extends Storable>(String collectionName, T item);
//
//   Future<bool> deleteItem<T extends Storable>(String collectionName, T item);
// }
//
// class BaseCollectionDatasourceImp extends BaseCollectionDatasource {
//   Future<Database> database;
//
//   BaseCollectionDatasourceImp() : database = _initDB();
//
//   static Future<Database> _initDB() async {
//     return openDatabase(
//       join(
//           await getDatabasesPath(), 'main_database${DataBaseConfig.dataBaseVersion.toString()}.db'),
//       onCreate: (db, version) async {
//         for (String tableName in DataBaseConfig.getAllTablesNames()) {
//           await db.execute(DataBaseConfig.createTableCommands[tableName]!);
//         }
//       },
//       onUpgrade: (db, oldVersion, newVersion) async {
//         for (String tableName in DataBaseConfig.getAllTablesNames()) {
//           await db.execute(DataBaseConfig.createTableCommands[tableName]!);
//         }
//       },
//       version: DataBaseConfig.dataBaseVersion,
//     );
//   }
//
//   @override
//   Future<bool> storeItem<T extends Storable>(String collectionName, T item) async {
//     Database database = await this.database;
//
//     int id = await database.insert(collectionName, item.toJson(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//
//     return id != 0;
//   }
//
//   @override
//   Future<bool> deleteItem<T extends Storable>(String collectionName, T item) async {
//     Database database = await this.database;
//
//     // Todo: consider make the id general: ${CartItemKeys.providerDrugId}
//     int id = await database
//         .delete(collectionName, where: '${CartItemKeys.providerDrugId} = ?', whereArgs: [item.id]);
//
//     return id != 0;
//   }
//
//   @override
//   Future<List<T>> getAll<T extends Storable>(
//       String collectionName, T Function(Map<String, dynamic> map) decoder) async {
//     Database database = await this.database;
//
//     final List<Map<String, dynamic>> maps = await database.query(collectionName);
//
//     return List.generate(maps.length, (i) {
//       return decoder(maps[i]);
//     });
//   }
// }
