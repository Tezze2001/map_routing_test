import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:map_routing_test/Domain/osrm_response.dart';
import 'package:result_dart/result_dart.dart';

class OsrmService {
  static const String _server = "router.project-osrm.org";
  static const String _resource = "/route/v1/car";
  String _additionalPath = "";

  Uri get uri =>
      Uri(scheme: "http", host: _server, path: _resource + _additionalPath);

  Future<Result<OsrmResponse>> getRoute(List<LatLng> points) async {
    String input = points
        .map((point) => "${point.longitude},${point.latitude}")
        .join(";");
    _additionalPath = "/$input";
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      OsrmResponse obj = OsrmResponse.fromJson(jsonDecode(response.body));
      return Success(obj);
    }
    return Failure(Exception('Error in getting the route'));
  }
}
