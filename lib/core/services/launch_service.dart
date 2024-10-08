import 'package:url_launcher/url_launcher.dart';

import '../utils/constants.dart';

class LunchUrlService {
  Future<void> launchPhone(String phone) async {
    final Uri phoneUri = Uri(
      scheme: 'tel', // The "tel" scheme for phone numbers
      path: phone,
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri); // Launch the phone call
    } else {
      throw 'Could not launch $phone';
    }
  }

  Future<void> launchUri(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  Future<void> launchEmail(email) async {
    if (!await launchUrl(Uri.parse("mailto:$email"))) {
      throw 'Could not launch $email';
    }
  }

  Future<void> launchMap(double latitude, double longitude,
      {bool withDestination = false}) async {
    String googleMapsUrl = "";
    String appleMapsUrl = "";
    if (withDestination) {
      googleMapsUrl =
          '${AppConstant.googleMapsDestinationUrl}$latitude,$longitude';
      appleMapsUrl =
          '${AppConstant.appleMapsDestinationUrl}$latitude,$longitude';
    } else {
      googleMapsUrl = '${AppConstant.googleMapsUrl}$latitude,$longitude';
      appleMapsUrl = '${AppConstant.appleMapsUrl}$latitude,$longitude';
    }

    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
    } else if (await canLaunchUrl(Uri.parse(appleMapsUrl))) {
      await launchUrl(Uri.parse(appleMapsUrl));
    } else {
      throw 'Could not launch maps';
    }
  }
}
