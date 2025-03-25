import 'package:latlong2/latlong.dart';
import 'package:map_routing_test/Domain/osrm_response.dart';
import 'package:map_routing_test/Domain/route_model.dart';
import 'package:map_routing_test/service/osrm_service.dart';
import 'package:result_dart/result_dart.dart';

class RouteRepository {
  final OsrmService _routeService;

  RouteRepository({required OsrmService routeService})
    : _routeService = routeService;

  Future<Result<RouteModel>> getRoute(List<LatLng> points) async {
    Result<OsrmResponse> resp = await _routeService.getRoute(points);
    try {
      final value = resp.getOrThrow();
      return Success(RouteModel.fromRawData(value));
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
