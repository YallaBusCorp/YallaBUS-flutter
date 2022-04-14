import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';

import '../../../../core/position_locator/locator.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  Completer<GoogleMapController> controller = Completer();
  late Position _position;
  final Set<Marker> markers = <Marker>{};

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(30.8357675, 30.7956597),
    zoom: 10,
  );
  MapBloc() : super(MapInitial()) {
    on<GetMyLocation>((event, emit) async {
      final GoogleMapController con = await controller.future;
      _position = await determinePosition();
      BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        AssetManager.placeMarker,
      );

      markers.add(
        Marker(
          markerId: MarkerId(
            LatLng(_position.latitude, _position.longitude).toString(),
          ),
          position: LatLng(
              _position.latitude, _position.longitude), //position of marker

          icon: markerbitmap,
        ),
      );
      final CameraPosition _kLake = CameraPosition(
          bearing: 0,
          target: LatLng(_position.latitude, _position.longitude),
          tilt: 0,
          zoom: 19.151926040649414);
      con.animateCamera(CameraUpdate.newCameraPosition(_kLake));
      emit(ChangePosition());
    });
    // on<GetMarkers>((event, emit) {

    //   emit(DrawMarkers( markers));
    // });
  }
}
