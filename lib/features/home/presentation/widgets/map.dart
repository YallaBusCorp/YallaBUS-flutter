import 'dart:async';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yalla_bus/features/home/presentation/bloc/map_bloc.dart';

import '../../../../core/position_locator/locator.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MapBloc map = BlocProvider.of<MapBloc>(context);
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return GoogleMap(
          myLocationButtonEnabled: false,
          markers: map.markers,
          initialCameraPosition: map.kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            map.controller.complete(controller);
          },
        );
      },
    );
  }
}
