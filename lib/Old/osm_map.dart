import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:map_routing_test/Domain/map_model.dart';

class OSMMap {
  final MapData mapData;

  OSMMap({required this.mapData});

  MapController mapController = MapController.withUserPosition(
    trackUserLocation: UserTrackingOption(
      enableTracking: true,
      unFollowUser: false,
    ),
  );

  OSMOption mapOption = OSMOption(
    showContributorBadgeForOSM: true,
    userTrackingOption: UserTrackingOption(
      enableTracking: true,
      unFollowUser: false,
    ),
    zoomOption: ZoomOption(initZoom: 5),
  );

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
  }
}
