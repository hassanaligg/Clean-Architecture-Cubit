import 'package:dawaa24/core/utils/extentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;

  void monitorConnection(BuildContext context);
}

@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;
  bool firstTime = true;

  NetworkInfoImpl(this.connectionChecker) {
    // monitorConnection();
  }

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

  @override
  void monitorConnection(BuildContext context) {
    connectionChecker.onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          if (!firstTime) {
            context.isArabic
                ? "تم استعادة اتصال بالإنترنت.".showToast()
                : "Your internet connection was restored.".showToast();
          }
          break;
        case InternetConnectionStatus.disconnected:
          firstTime = false;
          context.isArabic
              ? "أنت غير متصل حاليًا.".showToast()
              : "You are currently offline.".showToast();
          break;
      }
    });
  }
}
