import 'package:geocoding/geocoding.dart' as geo;
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';

@injectable
class LocationHelper {
  LocationData? _locationData;

  LocationData? get location => _locationData;

  Future<LocationData?> getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    PermissionStatus permissionGranted;
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    try {
      LocationData locationData = await location.getLocation();
      return locationData;
    } catch (e) {
      print("Error getting location: $e");
      return null;
    }
  }

  Future<geo.Placemark> getLocationAddressFromLatLng({
    required double lat,
    required double long,
  }) async {
    var res = await geo.placemarkFromCoordinates(
      lat,
      long,
    );

    return res[0];
  }
}
