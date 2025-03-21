import 'package:flutter_map/flutter_map.dart';
import 'package:map_routing_test/Domain/flatter_map.dart';
import 'package:map_routing_test/Domain/osm_map.dart';

class HomeViewModel {
  final OSMMap osmMap;
  final FLATTERMap flutterMap;

  HomeViewModel({required this.osmMap, required this.flutterMap});
}
