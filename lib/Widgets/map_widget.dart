import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_routing_test/Domain/flatter_map.dart';
import 'package:map_routing_test/service/location_service.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({required this.mapController, required this.mapOptions});

  final MapController mapController;
  final MapOptions mapOptions;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LocationService.getCurrentLocation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text("Error"));
        }

        Position pos = snapshot.data as Position;

        return FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: LatLng(pos.latitude, pos.longitude),
            initialZoom: 15,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'dev.test.example',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(pos.latitude, pos.longitude),
                  width: 48,
                  height: 48,
                  child: Icon(
                    Icons.navigation_rounded, // Choose an appropriate icon
                    size: 48,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
