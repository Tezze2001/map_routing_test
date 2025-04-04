import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:map_routing_test/Domain/map_model.dart';
import 'package:map_routing_test/Repository/route_repository.dart';
import 'package:map_routing_test/Screen/home_screen.dart';
import 'package:map_routing_test/service/osrm_service.dart';
import 'package:provider/provider.dart';
import 'ViewModels/home_view_model.dart';

void main() {
  final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return HomeScreen(
            viewModel: HomeViewModel(
              mapModel: MapModel(),
              routeRepository: context.read(),
            ),
          );
        },
      ),
    ],
  );

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => OsrmService()),
        Provider(
          create: (context) => RouteRepository(routeService: context.read()),
        ),
      ],
      child: MaterialApp.router(title: 'Hello World', routerConfig: router),
    ), // put dependency injection for Repository and service using providers
  );
  //runApp(MaterialApp.router(title: 'Hello World', routerConfig: router));
}
