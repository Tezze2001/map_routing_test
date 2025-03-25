import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_routing_test/Domain/osrm_leg_response.dart';
import 'package:map_routing_test/Domain/osrm_response.dart';
import 'package:map_routing_test/Domain/osrm_step_response.dart';

class RouteModel {
  List<String?>? geometries;

  RouteModel({required this.geometries});

  List<LatLng> get locations => getLocations();

  factory RouteModel.fromRawData(OsrmResponse response) {
    List<OsrmLegResponse>? legs =
        response.routes
            .expand((element) => element.legs as List<OsrmLegResponse>)
            .toList();

    List<OsrmStepResponse>? steps =
        legs
            .expand((element) => element.steps as List<OsrmStepResponse>)
            .toList();

    List<String?>? geometries = steps.map((e) => e.geometry).toList();

    return RouteModel(geometries: geometries);
  }

  List<LatLng> getLocations() {
    PolylinePoints polylinePoints = PolylinePoints();
    List<List<PointLatLng>> points = [];
    for (var element in geometries!) {
      List<PointLatLng> result = polylinePoints.decodePolyline(element!);
      points.add(result);
    }

    List<LatLng> finalLocation =
        points
            .expand((element) => element)
            .map((e) => LatLng(e.latitude, e.longitude))
            .toList();
    return finalLocation;
  }
}
