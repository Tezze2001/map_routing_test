import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class OsrmService {
  static const String server = "router.project-osrm.org"; 
  static const String _resource = "/route/v1/car"; 

  Uri uri = Uri(
    scheme: "http",
    host: "router.project-osrm.org",
    path: "route/v1/car",
  );

  Future<http.Response> getRoute(List<LatLng> points) {
    String input = points
        .map((point) => "${point.longitude},${point.latitude}")
        .join(";");
    http.get(Uri.parse())
  }
}
