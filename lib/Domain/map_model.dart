import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_routing_test/service/location_service.dart';
import 'package:map_routing_test/utils.dart';

class MapModel {
  final List<LatLng> _positions = [];

  UnmodifiableListView<LatLng> get positions =>
      UnmodifiableListView(_positions);

  Future<Position> get actualPosition => LocationService.getCurrentLocation();

  LatLng _tempSelectedPosition = LatLng(0, 0);

  LatLng get tempSelectedPosition => _tempSelectedPosition;

  void addPosition(LatLng pos) {
    _positions.add(pos);
  }

  void setTempSelectedPosition(LatLng pos) {
    _tempSelectedPosition = pos;
  }

  void confirmSelectedPosition() {
    addPosition(_tempSelectedPosition);
  }

  void removePosition(LatLng pos) {
    _positions.remove(pos);
  }
}
