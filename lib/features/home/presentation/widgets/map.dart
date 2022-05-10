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

class _MapWidgetState extends State<MapWidget> with WidgetsBindingObserver {
  late String _darkMapStyle;
  late String _lightMapStyle;

  @override
  void initState() {
    _loadMapStyles();
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString(AssetManager.darkMapStyle);
    _lightMapStyle = await rootBundle.loadString(AssetManager.lightMapStyle);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    MapBloc bloc = BlocProvider.of<MapBloc>(context);
    if (state == AppLifecycleState.resumed) {
      final GoogleMapController controller = await bloc.controller.future;
      if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
        controller.setMapStyle(_darkMapStyle);
      } else {
        controller.setMapStyle(_lightMapStyle);
      }
    }
    super.didChangeAppLifecycleState(state);
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
          markers: markers.union(map.markers),
          myLocationButtonEnabled: false,
          compassEnabled: false,
          mapToolbarEnabled: false,
          initialCameraPosition: map.kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            if (!map.controller.isCompleted) {
              map.controller.complete(controller);
              map.add(GetMyLocation());
            }
            if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
              controller.setMapStyle(_darkMapStyle);
            } else {
              controller.setMapStyle(_lightMapStyle);
            }
          },
        );
      },
    );
  }
}
