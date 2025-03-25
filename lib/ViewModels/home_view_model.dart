import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_routing_test/Domain/map_model.dart';
import 'package:map_routing_test/Domain/route_model.dart';
import 'package:map_routing_test/Repository/route_repository.dart';
import 'package:result_dart/result_dart.dart';

class HomeViewModel extends ChangeNotifier {
  final MapModel mapModel;
  RouteModel? routeModel;
  final RouteRepository routeRepository;

  HomeViewModel({required this.mapModel, required this.routeRepository});

  void addPosition(LatLng pos) {
    mapModel.addPosition(pos);
    notifyListeners();
  }

  void setTempSelectedPosition(LatLng pos) {
    mapModel.setTempSelectedPosition(pos);
    notifyListeners();
  }

  void confirmSelectedPosition() {
    mapModel.confirmSelectedPosition();
    notifyListeners();
  }

  void removePosition(LatLng pos) {
    mapModel.removePosition(pos);
    notifyListeners();
  }

  void updatePolylinePositions() async {
    Result<RouteModel> route = await routeRepository.getRoute(
      mapModel.positions,
    );

    RouteModel resp = route.getOrThrow();
    if (resp.geometries != null) {
      routeModel = resp;
      notifyListeners();
    }
  }
}
