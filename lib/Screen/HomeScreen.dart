import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as flatter_map;
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' as osm;
import 'package:map_routing_test/ViewModels/HomeViewModel.dart';
import 'package:map_routing_test/Widgets/map_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.viewModel});

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Demo maps'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bike)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            osm.OSMFlutter(
              controller: viewModel.osmMap.mapController,
              osmOption: viewModel.osmMap.mapOption,
              mapIsLoading: CircularProgressIndicator(
                constraints: BoxConstraints(maxHeight: 64, maxWidth: 64),
              ),
            ),
            MapWidget(
              mapController: viewModel.flutterMap.mapController,
              mapOptions: viewModel.flutterMap.mapOptions,
            ),
            Icon(Icons.directions_bike),
          ],
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.deepPurple),
                child: Text('Select the positions'),
              ),
              ListTile(
                title: Text('Select starting position'),
                subtitle: ListenableBuilder(
                  listenable: viewModel.osmMap.mapData,
                  builder: (BuildContext context, Widget? child) {
                    final startingPosition =
                        viewModel.osmMap.mapData.startingPosition;

                    if (startingPosition != null) {
                      return Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Align left
                        children: [
                          Text('Latitude: ${startingPosition.latitude}'),
                          Text('Longitude: ${startingPosition.longitude}'),
                        ],
                      );
                    }

                    return const Text('No position available');
                  },
                ),
                onTap: () async {
                  try {
                    FocusScope.of(context).unfocus();
                    await viewModel.osmMap.pickStartingLocation(context);
                  } catch (ex) {
                    print('Error in pickup dialog: $ex');
                  }
                },
              ),
              ListTile(
                title: Text('Select ending position'),
                subtitle: ListenableBuilder(
                  listenable: viewModel.osmMap.mapData,
                  builder: (BuildContext context, Widget? child) {
                    final startingPosition =
                        viewModel.osmMap.mapData.endingPosition;

                    if (startingPosition != null) {
                      return Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Align left
                        children: [
                          Text('Latitude: ${startingPosition.latitude}'),
                          Text('Longitude: ${startingPosition.longitude}'),
                        ],
                      );
                    }

                    return const Text('No position available');
                  },
                ),
                onTap: () async {
                  try {
                    FocusScope.of(context).unfocus();
                    await viewModel.osmMap.pickEndingLocation(context);
                  } catch (ex) {
                    print('Error in pickup dialog: $ex');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
