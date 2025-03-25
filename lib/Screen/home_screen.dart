import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as flatter_map;
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' as osm;
import 'package:map_routing_test/ViewModels/home_view_model.dart';
import 'package:map_routing_test/Widgets/map_widget.dart';
import 'package:map_routing_test/Widgets/position_picker_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.viewModel});

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo maps')),
      body: ListenableBuilder(
        listenable: viewModel.mapModel,
        builder: (BuildContext context, Widget? child) {
          return MapWidget(
            actualPosition: viewModel.mapModel.actualPosition,
            markers: viewModel.mapModel.positions,
          );
        },
      ),
      floatingActionButton: Stack(
        children: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ListenableBuilder(
                    listenable: viewModel.mapModel,
                    builder: (context, child) {
                      return PositionPickerWidget(
                        onLocationSelected:
                            () => viewModel.mapModel.confirmSelectedPosition(),
                        onUpdateLocationSelected:
                            (p0) =>
                                viewModel.mapModel.setTempSelectedPosition(p0),
                        tempLocation: viewModel.mapModel.tempSelectedPosition,
                        actualLocation: viewModel.mapModel.actualPosition,
                      );
                    },
                  );
                },
              );
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              debugPrint("iiiiii");
            },
            icon: Icon(Icons.directions),
          ),
        ],
      ),
    );
  }
}
