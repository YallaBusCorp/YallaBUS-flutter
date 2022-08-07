import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/resources/constants_manager.dart';
import '../../../../core/resources/map_manager.dart';
import '../bloc/map/pickup_dropoff_info.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/resources/asset_manager.dart';
import '../bloc/map/map_bloc.dart';
import '../bloc/ride_booked/ride_booked_bloc.dart';

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
  late RideBookedBloc _rideBookedBloc;
  late Stream<DocumentSnapshot> tracking;

  @override
  void initState() {
    _loadMapStyles();
    bloc = BlocProvider.of<MapBloc>(context);
    _rideBookedBloc = BlocProvider.of<RideBookedBloc>(context);
    WidgetsBinding.instance!.addObserver(this);
    tracking = FirebaseFirestore.instance
        .collection('company')
        .doc(bloc.perfs.getString(ConstantsManager.companyName))
        .collection('ride')
        .doc(bloc.perfs.getString(ConstantsManager.rideID) ?? 'h')
        .snapshots();

    super.initState();
  }

  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString(AssetManager.darkMapStyle);
    _lightMapStyle = await rootBundle.loadString(AssetManager.lightMapStyle);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
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
    return StreamBuilder<DocumentSnapshot>(
        stream: tracking,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          FirebaseExtensions.CheckIfDocumentExistsOrNotEvent(
                  bloc.perfs.getString(ConstantsManager.rideID) ?? 'h')
              .then((value) => x = value);
          if (snapshot.hasData && x) {
            geoPoints = snapshot.data!.get('location');
            int size = geoPoints.length;
            point = geoPoints[size - 1];
            bloc.add(RefreshBusCoordinateEvent(
                LatLng(point.latitude, point.longitude), context));
            bloc.add(CheckBusMarkerAccordingToPickAndDropMarkersEvent(
                LatLng(point.latitude, point.longitude),
                PickUpAndDropOffInfo.pickUpSelectedPosition,
                PickUpAndDropOffInfo.dropOffSelectedPosition));
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
                markers = MapManager.markersOfBus;
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
                  if (!bloc.controller.isCompleted) {
                    bloc.controller.complete(controller);
                    if (MapManager.markersOfBus.isEmpty) {
                      bloc.add(GetMyLocation());
                    }
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
