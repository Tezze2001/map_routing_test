import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_routing_test/utils.dart';

class PositionPickerWidget extends StatelessWidget {
  final Function() onLocationSelected;
  final Function(LatLng) onUpdateLocationSelected;
  final Future<Position> actualLocation;
  final LatLng tempLocation;

  PositionPickerWidget({
    super.key,
    required this.onLocationSelected,
    required this.onUpdateLocationSelected,
    required this.actualLocation,
    required this.tempLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pick a Location')),
      body: Stack(
        children: [
          FutureBuilder(
            future: actualLocation,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(child: Text("Error"));
              }

              Position pos = snapshot.data as Position;

              return FlutterMap(
                mapController: MapController(),
                options: MapOptions(
                  initialCenter: convertPositionToLatLng(pos),
                  initialZoom: 13,
                  onTap:
                      (tapPosition, point) => onUpdateLocationSelected(point),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'dev.test.example',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(pos.latitude, pos.longitude),
                        width: 48,
                        height: 48,
                        child: Icon(
                          Icons
                              .navigation_rounded, // Choose an appropriate icon
                          size: 48,
                          color: Colors.blue,
                        ),
                      ),
                      Marker(
                        point: tempLocation,
                        width: 48,
                        height: 48,
                        child: Icon(
                          Icons.location_on, // Choose an appropriate icon
                          size: 48,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                onLocationSelected();
                Navigator.pop(context);
              },
              child: Text('Confirm Location'),
            ),
          ),
        ],
      ),
    );
  }
}
