import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yalla_bus/features/home/presentation/bloc/map_bloc.dart';

import '../../../../core/position_locator/locator.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late String _darkMapStyle;

  @override
  void initState() {
    super.initState();
    _loadMapStyles();
  }

  Future _loadMapStyles() async {
    _darkMapStyle =
        await rootBundle.loadString('assets/map_style/dark_mode.json');
  }

  @override
  Widget build(BuildContext context) {
    MapBloc map = BlocProvider.of<MapBloc>(context);
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return GoogleMap(
          zoomControlsEnabled: false,
          markers: map.markers,
          initialCameraPosition: map.kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            map.controller.complete(controller);
            if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
              controller.setMapStyle(_darkMapStyle);
            }
          },
        );
      },
    );
  }
}
