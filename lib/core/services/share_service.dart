import 'package:dawaa24/core/utils/extentions.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

@singleton
class ShareService {
  static final ShareService _instance = ShareService._internal();

  factory ShareService() {
    return _instance;
  }

  ShareService._internal();

  Future<void> shareImage(String imageUrl, {String? withText}) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/image.jpg');
      await Dio().download(imageUrl, file.path);
      final result =
          await Share.shareXFiles([XFile(file.path)], text: withText ?? "");
      if (result.status == ShareResultStatus.success) {
        print('Image shared successfully!');
      } else {
        return "failures.some_thing_wrong".tr().showToast();
      }
    } catch (e) {
      return "failures.some_thing_wrong".tr().showToast();
    }
  }
}
