import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/features/home/presentation/bloc/map/map_bloc.dart';

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
    _darkMapStyle = await rootBundle.loadString(AssetManager.darkMapStyle);
  }

  @override
  void didChangeDependencies() {
    BlocProvider.of<MapBloc>(context).add(GetAmAppoinmentsEvent());
    BlocProvider.of<MapBloc>(context).add(GetPmAppoinmentsEvent());
    // BlocProvider.of<MapBloc>(context).add(CameraPositionOfPickUpPoints());
    super.didChangeDependencies();
  }

  Set<Marker> markers = <Marker>{};

  @override
  Widget build(BuildContext context) {
    MapBloc map = BlocProvider.of<MapBloc>(context);
    return BlocConsumer<MapBloc, MapState>(
      listener: (context, state) {
        if (state is PickUpPointsMarkersChanged) {
          markers = map.pickUpMarkers;
        }
        if (state is DropOffPointsMarkersChanged) {
          markers = map.dropOffMarkers;
        }
      },
      builder: (context, state) {
        return GoogleMap(
          
          zoomControlsEnabled: false,
          markers: markers,
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
