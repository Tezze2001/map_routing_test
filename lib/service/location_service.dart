import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<bool> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return false;
      }
    }
    return true;
  }

  static Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}
