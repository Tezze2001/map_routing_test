import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:map_routing_test/Domain/MapData.dart';

class FLATTERMap {
  final MapData mapData;

  FLATTERMap({required this.mapData});

  MapController mapController = MapController();
  MapOptions mapOptions = MapOptions();
  /*
  Future<GeoPoint?> pickLocation(BuildContext context, String title) async {
    Future<GeoPoint?> p = showSimplePickerLocation(
      context: context,
      isDismissible: true,
      title: title,
      textConfirmPicker: "pick",
      zoomOption: ZoomOption(initZoom: 5),
      initCurrentUserPosition: UserTrackingOption(
        enableTracking: true,
        unFollowUser: false,
      ),
    );
    return p;
  }

  Future<void> pickStartingLocation(BuildContext context) async {
    GeoPoint? p = await pickLocation(context, "Pick starting location");
    if (p != null) {
      if (mapData.startingPosition == null) {
        mapData.setStartingPosition(p);
        await mapController.addMarker(
          p,
          markerIcon: MarkerIcon(
            icon: Icon(Icons.location_on, color: Colors.red, size: 42),
          ),
        );
      } else {
        await mapController.changeLocationMarker(
          oldLocation: mapData.startingPosition!,
          newLocation: p,
        );
        mapData.setStartingPosition(p);
      }
    }
  }

  Future<void> pickEndingLocation(BuildContext context) async {
    GeoPoint? p = await pickLocation(context, "Pick ending location");
    if (p != null) {
      if (mapData.endingPosition == null) {
        mapData.setEndingPosition(p);
        await mapController.addMarker(
          p,
          markerIcon: MarkerIcon(
            icon: Icon(Icons.location_on, color: Colors.red, size: 42),
          ),
        );
      } else {
        await mapController.changeLocationMarker(
          oldLocation: mapData.endingPosition!,
          newLocation: p,
        );
        mapData.setEndingPosition(p);
      }
    }
  }*/
}
