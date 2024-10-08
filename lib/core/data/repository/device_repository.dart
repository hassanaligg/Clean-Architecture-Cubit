import 'package:injectable/injectable.dart';
import 'dart:io' show Platform;

@singleton
class DeviceRepository {
  int getUserSignupSourceId() {
    int result = 2;
    if (Platform.isIOS) {
      result = 3;
    } else {
      result = 2;
    }
    return result;
  }
}
