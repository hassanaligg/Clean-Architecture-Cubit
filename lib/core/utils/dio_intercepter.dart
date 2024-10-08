import 'dart:async';
import 'dart:io';

import 'package:dawaa24/core/data/enums/auth_state.dart';
import 'package:dawaa24/features/auth/domain/repository/auth_repository.dart';
import 'package:dio/dio.dart';

import '../../di/injection.dart';
import '../data/model/error/error_model.dart';
import 'failures/http/http_failure.dart';
import 'handler/auth_handler.dart';

class AppInterceptors extends Interceptor {
  final AuthHandler authHandler;

  AppInterceptors(this.authHandler);

  @override
  FutureOr<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers.containsKey("withToken")) {
      try {
        final res = ((await getIt<AuthRepository>().getLocalToken()));
        Map<String, dynamic> headers = {'Authorization': 'Bearer $res'};
        options.headers.addAll(headers);
      } catch (e) {
        print("there is no token in local storage ${e.toString()}");
      }
    }
    final lang = ((await getIt<AuthRepository>().getLocalLang()));

    options.headers.addAll({
      'Token': '55188d21133131444e182ad1a95e19a6b5d220190513065835921',
      'Package': 'Dawaa24',
      'Accept-Language': lang
    });
    options.sendTimeout = const Duration(milliseconds: 60000);
    options.connectTimeout = const Duration(milliseconds: 60000);
    options.receiveTimeout = const Duration(milliseconds: 60000);

    handler.next(options);
  }

  // @override
  // FutureOr<dynamic> onError(DioException err,
  //     ErrorInterceptorHandler handler,) {
  //   switch (err.type) {
  //     case DioExceptionType.receiveTimeout:
  //     case DioExceptionType.connectionTimeout:
  //     case DioExceptionType.sendTimeout:
  //       throw const TimeOutFailure();
  //     case DioExceptionType.connectionError:
  //       throw const NoInternetFailure();
  //
  //     case DioExceptionType.response:
  //       int statusCode = err.response?.statusCode ?? -1;
  //
  //       HttpFailure failure;
  //       if (statusCode == HttpStatus.unauthorized ||
  //           statusCode == HttpStatus.forbidden) {
  //         failure = const UnauthorizedFailure();
  //         authHandler.changeAuthState(AuthState.unAuthenticated);
  //       } else if (statusCode == HttpStatus.badRequest) {
  //         failure =
  //             BadRequestFailure(err.response?.data['error']["message"] ?? "");
  //       } else if (statusCode > 500) {
  //         failure = const ServerFailure();
  //       }
  //       // else if (statusCode == 412) {
  //       //   //fixed value to check if user is registered but not verified yet
  //       //   failure = const NotVerifiedFailure();
  //       // }
  //       else {
  //         String errorMessage = 'Unknown Error!';
  //         try {
  //           errorMessage = err.response?.data['error'] != null
  //               ? ErrorModel
  //               .fromJson(err.response?.data['error'])
  //               .message ??
  //               "Unknown Error!"
  //               : 'Unknown Error!';
  //         } finally {
  //           failure = CustomFailure(message: errorMessage);
  //         }
  //       }
  //       throw failure;
  //
  //     case DioErrorType.cancel:
  //       throw const CancelRequestFailure();
  //   }
  //
  //   // handler.next(err);
  // }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    {
      HttpFailure failure;
      if (err.type == DioExceptionType.unknown) {
        if (err.response?.statusCode == HttpStatus.unauthorized) {
          failure = const UnauthorizedFailure();
          authHandler.changeAuthState(AuthState.unAuthenticated);
        } else if (err.response?.statusCode == HttpStatus.forbidden) {
          failure = CustomFailure(
              message: err.response?.data['error']["message"] ?? "");
        } else if (err.response?.statusCode == 404) {
          failure = CustomFailure(
              message: err.response?.data['error']["message"] ?? "");
        } else if (err.response!.statusCode! >= 500) {
          failure = const ServerFailure();
        }
      } else if (err.type == DioExceptionType.connectionError ||
          err.type == DioExceptionType.sendTimeout ||
          err.type == DioExceptionType.receiveTimeout ||
          err.type == DioExceptionType.cancel) {
        throw const NoInternetFailure();
      } else if (err.type == DioExceptionType.badResponse) {
        int statusCode = err.response?.statusCode ?? -1;
        if ((statusCode == HttpStatus.unauthorized) &&
            (!err.requestOptions.uri
                .toString()
                .contains("/api/app/Auth/RefreshToken"))) {
          if (err.requestOptions.uri
              .toString()
              .contains("/app/auth/AuthenticateUser")) {
            String errorMessage = 'Unknown Error!';
            errorMessage = err.response?.data['error'] != null
                ? ErrorModel.fromJson(err.response?.data['error']).message
                : 'Unknown Error!';
            if (err.response?.data['error']?['validationErrors'] != null &&
                err.response?.data['error']['validationErrors'].length > 0) {
              errorMessage =
                  err.response?.data['error']['validationErrors'][0]['message'];
            }
            failure = CustomFailure(message: errorMessage);
            throw failure;
          } else {
            _handleError(err, handler);
          }
        } else if (err.type == DioExceptionType.badResponse) {
          String errorMessage = 'Unknown Error!';
          errorMessage = err.response?.data['error'] != null
              ? ErrorModel.fromJson(err.response?.data['error']).message
              : 'Unknown Error!';
          if (err.response?.data['error']?['validationErrors'] != null &&
              err.response?.data['error']['validationErrors'].length > 0) {
            errorMessage =
                err.response?.data['error']['validationErrors'][0]['message'];
          }
          failure = CustomFailure(message: errorMessage);

          throw failure;
        } else if (err.response?.statusCode == HttpStatus.forbidden) {
          failure = CustomFailure(
              message: err.response?.data['error']["message"] ?? "");

          throw failure;
        } else {
          failure = const UnauthorizedFailure();
          throw failure;
        }
      } else {
        String errorMessage = 'Unknown Error!';
        try {
          errorMessage = err.response?.data['error'] != null
              ? ErrorModel.fromJson(err.response?.data['error']).message
              : 'Unknown Error!';
          if (err.response?.data['error']?['validationErrors'] != null &&
              err.response?.data['error']['validationErrors'].length > 0) {
            errorMessage =
                err.response?.data['error']['validationErrors'][0]['message'];
          }
        } finally {
          failure = CustomFailure(message: errorMessage);
        }
        throw failure;
      }
    }
  }

  _handleError(DioException err, ErrorInterceptorHandler handler) async {
    HttpFailure failure;
    try {
      // Attempt to refresh the token
      bool refreshStatus = await getIt<AuthRepository>().refreshToken();
      if (refreshStatus) {
        // Resend the original request with the new token
        RequestOptions originalOptions = err.requestOptions;
        final newToken = await getIt<AuthRepository>().getLocalToken();
        Map<String, dynamic> headers = {
          'Authorization': 'Bearer $newToken',
          'Token': '55188d21133131444e182ad1a95e19a6b5d220190513065835921',
          'Package': 'Dawaa24'
        };
        originalOptions.headers.addAll(headers);

        // Retry the request
        final response = await Dio().fetch(originalOptions);
        return handler.resolve(response);
      } else {
        failure = const UnauthorizedFailure();
        authHandler.changeAuthState(AuthState.unAuthenticated);
        getIt<AuthRepository>().logOut();
      }
    } catch (e) {
      authHandler.changeAuthState(AuthState.unAuthenticated);
      getIt<AuthRepository>().logOut();
      failure = const UnauthorizedFailure();
      throw failure;
    }
  }
}
