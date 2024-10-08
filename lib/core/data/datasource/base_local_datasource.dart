import 'dart:convert';

import 'package:dawaa24/core/utils/failures/local_storage/local_storage_failure.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseLocalDataSource {
  Future<bool> write<T>({
    required String key,
    required T data,
    required Map<String, dynamic> Function(T obj) encoder,
  });

  Future<T> read<T>({
    required String key,
    required T Function(Map<String, dynamic> data) decoder,
  });
}

@LazySingleton(as: BaseLocalDataSource)
class BaseLocalDataSourceImp extends BaseLocalDataSource {
  final SharedPreferences sharedPreferences;

  BaseLocalDataSourceImp(this.sharedPreferences);

  @override
  Future<T> read<T>({required String key, required T Function(Map<String, dynamic> data) decoder}) {
    String? raw = sharedPreferences.getString(key);
    if (raw != null) {
      try {
        Map<String, dynamic> data = json.decode(raw);
        return Future.value(decoder(data));
      } catch (e) {
        throw (BadDataFailure());
      }
    } else {
      throw (DataNotExistFailure());
    }
  }

  @override
  Future<bool> write<T>(
      {required String key,
      required T data,
      required Map<String, dynamic> Function(T obj) encoder}) {
    return sharedPreferences.setString(key, json.encode(data));
  }
}
