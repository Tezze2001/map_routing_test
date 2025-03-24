import 'package:latlong2/latlong.dart';
import 'package:map_routing_test/Domain/map_model.dart';

class HomeViewModel {
  final MapModel mapModel;

  HomeViewModel({required this.mapModel});

  void addPosition(LatLng pos) {
    mapModel.addPosition(pos);
  }
}
