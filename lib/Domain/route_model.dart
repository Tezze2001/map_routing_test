import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:map_routing_test/Domain/osrm_leg_response.dart';
import 'package:map_routing_test/Domain/osrm_response.dart';
import 'package:map_routing_test/Domain/osrm_step_response.dart';

class RouteModel {
  List<String?>? geometries;

  RouteModel({required this.geometries});

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
}
