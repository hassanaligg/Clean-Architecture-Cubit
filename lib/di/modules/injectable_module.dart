import 'dart:async';

import 'package:dawaa24/core/utils/dio_intercepter.dart';
import 'package:dawaa24/di/injection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/handler/auth_handler.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


@module
abstract class InjectableModule {
  @lazySingleton
  InternetConnectionChecker get connectionChecker =>
      InternetConnectionChecker();

  @preResolve
  @lazySingleton
  Future<SharedPreferences> get sharedPref => SharedPreferences.getInstance();

  @lazySingleton
  Dio get dioInstance {
    final dio = Dio(
      BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          validateStatus: (statusCode) {
            if (statusCode != null) {
              if (200 <= statusCode && statusCode < 300) {
                return true;
              } else {
                return false;
              }
            } else {
              return false;
            }
          }),
    );

    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        compact: false,
        maxWidth: 2000,
        logPrint: (line) {
          if (kDebugMode) {
            print(line);
          }
        }));

    dio.interceptors.add(AppInterceptors(
        getIt.get<AuthHandler>()));

    return dio;
  }
}
