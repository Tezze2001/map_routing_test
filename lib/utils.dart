import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

LatLng convertPositionToLatLng(Position pos) {
  return LatLng(pos.latitude, pos.longitude);
}
