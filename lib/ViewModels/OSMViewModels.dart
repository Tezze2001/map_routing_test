import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:map_routing_test/Domain/MapData.dart';

class OSMViewModels extends ChangeNotifier {
  OSMViewModels({required MapController osmController})
    : _osmController = osmController;

  final MapController _osmController;

  MapController get osmController {
    return _osmController;
  }

  void addPosition(GeoPoint pos) {
    _osmController.addMarker(
      pos,
      markerIcon: MarkerIcon(icon: Icon(Icons.location_on)),
    );
  }
}
