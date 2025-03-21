import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:map_routing_test/Domain/MapData.dart';
import 'package:map_routing_test/Domain/flatter_map.dart';
import 'package:map_routing_test/Domain/osm_map.dart';
import 'package:map_routing_test/Screen/HomeScreen.dart';
import 'ViewModels/HomeViewModel.dart';

void main() {
  MapData mapData = MapData(startingPosition: null, endingPosition: null);
  final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return HomeScreen(
            viewModel: HomeViewModel(
              osmMap: OSMMap(mapData: mapData),
              flutterMap: FLATTERMap(mapData: mapData),
            ),
          );
        },
      ),
    ],
  );

  /*runApp(
    MultiProvider(
      providers: [],
      child: MaterialApp.router(title: 'Hello World', routerConfig: router),
    ), // put dependency injection for Repository and service using providers
  );*/
  runApp(MaterialApp.router(title: 'Hello World', routerConfig: router));
}
