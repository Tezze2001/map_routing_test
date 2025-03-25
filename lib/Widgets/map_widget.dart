import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_routing_test/service/location_service.dart';
import 'package:map_routing_test/utils.dart';

class MapWidget extends StatelessWidget {
  MapWidget({required this.actualPosition, this.markers, this.routePositions});

  final MapController mapController = MapController();
  Future<Position> actualPosition;
  final List<LatLng>? markers;
  final List<LatLng>? routePositions;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: actualPosition,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text("Error"));
        }

        Position pos = snapshot.data as Position;

        List<Widget> childrenMap = [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
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
        ];

        if (markers != null) {
          List<Marker> markersList = [];
          for (LatLng el in markers!) {
            markersList.add(
              Marker(
                point: el,
                width: 48,
                height: 48,
                child: Icon(
                  Icons.location_on, // Choose an appropriate icon
                  size: 48,
                  color: Colors.red,
                ),
              ),
            );
          }

          childrenMap.add(MarkerLayer(markers: markersList));
        }

        if (routePositions != null) {
          childrenMap.add(
            PolylineLayer(
              polylines: [
                Polyline(points: routePositions!, color: Colors.blue),
              ],
            ),
          );
        }

        return FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: convertPositionToLatLng(pos),
            initialZoom: 13,
          ),
          children: childrenMap,
        );
      },
    );
  }
}
