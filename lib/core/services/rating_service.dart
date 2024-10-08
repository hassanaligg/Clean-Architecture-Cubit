import 'package:dawaa24/core/utils/constants.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io' show Platform;
import 'package:launch_review/launch_review.dart';

class RatingService {


  Future<String> getPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.packageName;
  }

  Future rateOnStore() async {
    String packageName = await getPackageName();
    LaunchReview.launch(
        androidAppId: packageName, iOSAppId: AppConstant.iosAppId);
  }
}
