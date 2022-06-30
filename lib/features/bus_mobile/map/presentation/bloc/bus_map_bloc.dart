import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/features/bus_mobile/map/api/all_coordinates.dart';

import '../../../../../core/position_locator/locator.dart';
import '../../../../../core/resources/map_manager.dart';
import '../../../rides/domain/entity/all_rides.dart';

part 'bus_map_event.dart';
part 'bus_map_state.dart';

class BusMapBloc extends Bloc<BusMapEvent, BusMapState> {
  Completer<GoogleMapController> controller = Completer();

  Location location = Location();
  late LocationData myLocation;
  CoordinateApiClient client;
  final Set<Marker> markers = <Marker>{};
  List<LatLng> list = [];
  CameraPosition kGooglePlex = const CameraPosition(
      target: LatLng(
          (30.85389579312156 + 30.750389209369917 + 30.95670425388353) / 3,
          (31.268433318547288 + 31.260458997797773 + 31.30646424602145) / 3),
      zoom: 12);

  BusMapBloc(this.client) : super(BusMapInitial()) {
    on<BusMapEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetBusLocation>((event, emit) async {
      final GoogleMapController con = await controller.future;
      myLocation = await determineLocation();
      final CameraPosition cameraPosition = CameraPosition(
          bearing: 0,
          target: LatLng(myLocation.latitude!, myLocation.longitude!),
          tilt: 0,
          zoom: 19.151926040649414);
      final m = markers.firstWhere(
        (element) => element.markerId.value == '1',
        orElse: () => const Marker(
          markerId: MarkerId('3553'),
        ),
      );
      markers.remove(m);
      markers.add(
        Marker(
          markerId: const MarkerId('1'),
          icon: await MapManager.bitmapDescriptorFromSvgAsset(
              event.context, AssetManager.busIconTracking),
          position: LatLng(myLocation.latitude!, myLocation.longitude!),
          anchor: const Offset(0.5, 0.5),
        ),
      );
      con.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      emit(ChangePosition(markers));
    });

    on<InitializeBusMarkersEvent>((event, emit) async {
      markers.clear();
      event.bookings.map(
        (e) async => markers.add(
          Marker(
            markerId: const MarkerId('1'),
            icon: await MapManager.bitmapDescriptorFromSvgAsset(
                event.context, AssetManager.busStationSvg),
            position: LatLng(e.pickUp.latitude, e.pickUp.longitude),
            anchor: const Offset(0.5, 0.5),
          ),
        ),
      );
      event.bookings.map(
        (e) async => markers.add(
          Marker(
            markerId: const MarkerId('2'),
            icon: await MapManager.stationIcon(),
            position: LatLng(e.dropOff.latitude, e.dropOff.longitude),
            anchor: const Offset(0.5, 0.5),
          ),
        ),
      );
      emit(InitalizeMarkers());
    });

    on<BusMovesEvent>((event, emit) async {
      list = await client.getAllCoordinates(event.a, event.b);
      emit(GetListOfCoordinates(list));
    });

    on<RefershBusEvent>((event, emit) async {
      final GoogleMapController con = await controller.future;
      final CameraPosition cameraPosition = CameraPosition(
          bearing: 0,
          target: LatLng(event.x.latitude, event.x.longitude),
          tilt: 0,
          zoom: 13.5);
      markers.clear();
      markers.add(
        Marker(
          markerId: const MarkerId('1'),
          icon: await MapManager.bitmapDescriptorFromSvgAsset(
              event.context, AssetManager.busIconTracking),
          position: LatLng(event.x.latitude, event.x.longitude),
          anchor: const Offset(0.5, 0.5),
        ),
      );
      con.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      emit(ChangePosition(markers));
    });
  }
}
