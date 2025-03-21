import 'package:flutter/widgets.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapData extends ChangeNotifier {
  GeoPoint? startingPosition;
  GeoPoint? endingPosition;

  MapData({this.startingPosition, this.endingPosition});

  void setStartingPosition(GeoPoint pos) {
    startingPosition = pos;
    notifyListeners();
  }

  void setEndingPosition(GeoPoint pos) {
    endingPosition = pos;
    notifyListeners();
  }
}
