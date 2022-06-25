import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yalla_bus/core/custom_widgets/loading_dialog.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';
import 'package:yalla_bus/core/resources/map_manager.dart';
import '../../../../core/custom_widgets/error_dialog.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/injection/di.dart';
import '../../../../core/resources/asset_manager.dart';
import '../../../../core/resources/notification_manager.dart';
import '../../../../core/resources/routes_manager.dart';
import '../bloc/map/map_bloc.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> with WidgetsBindingObserver {
  late String _darkMapStyle;
  late String _lightMapStyle;
  late List<dynamic> geoPoints;
  late GeoPoint point;
  bool x = false;
  late MapBloc bloc;

  @override
  void initState() {
    _loadMapStyles();
    bloc = BlocProvider.of<MapBloc>(context);
    WidgetsBinding.instance!.addObserver(this);

    super.initState();
  }

  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString(AssetManager.darkMapStyle);
    _lightMapStyle = await rootBundle.loadString(AssetManager.lightMapStyle);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final GoogleMapController controller = await MapManager.controller.future;
      if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
        controller.setMapStyle(_darkMapStyle);
      } else {
        controller.setMapStyle(_lightMapStyle);
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  Stream<DocumentSnapshot> tracking = FirebaseFirestore.instance
      .collection('company')
      .doc('serkes')
      .collection('ride')
      .doc('hamo')
      .snapshots();

  Set<Marker> markers = <Marker>{};
  @override
  Widget build(BuildContext context) {
    MapBloc map = BlocProvider.of<MapBloc>(context);
    return StreamBuilder<DocumentSnapshot>(
        stream: tracking,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          MapExtensions.CheckIfDocumentExistsOrNotEvent(bloc.perfs.getString(ConstantsManager.rideID)!)
              .then((value) => x = value);
          if (x) {
            geoPoints = snapshot.data!.get('location');
            int size = geoPoints.length;
            point = geoPoints[size - 1];
            map.add(RefreshBusCoordinateEvent(point));
            map.add(CheckBusMarkerAccordingToPickAndDropMarkersEvent(
                LatLng(point.latitude, point.longitude),
                map.pickUpSelectedPosition,
                map.dropOffSelectedPosition));
          }

          return BlocConsumer<MapBloc, MapState>(
            listener: (context, state) {
              if (state is PickUpPointsMarkersChanged) {
                markers = MapManager.pickUpMarkers;
              }
              
              if (state is DropOffPointsMarkersChanged) {
                markers = MapManager.dropOffMarkers;
              }
              if (state is ChangeMarkersOfBus) {
                markers = map.markersOfBus;
              }
            },
            builder: (conetxt, state) {
              return GoogleMap(
                zoomControlsEnabled: false,
                markers: markers.union(MapManager.markers),
                myLocationButtonEnabled: false,
                compassEnabled: false,
                mapToolbarEnabled: false,
                initialCameraPosition: MapManager.kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  if (!MapManager.controller.isCompleted) {
                    MapManager.controller.complete(controller);
                    // map.add(GetMyLocation());
                  }
                  if (MediaQuery.of(context).platformBrightness ==
                      Brightness.dark) {
                    controller.setMapStyle(_darkMapStyle);
                  } else {
                    controller.setMapStyle(_lightMapStyle);
                  }
                },
              );
            },
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
  }
}
