import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';

class MapManager {
  static Completer<GoogleMapController> controller = Completer();

  static late Position position;

  static final Set<Marker> markers = <Marker>{};
  static final Set<Marker> dropOffMarkers = <Marker>{};
  static final Set<Marker> pickUpMarkers = <Marker>{};

  static CameraPosition kGooglePlex = const CameraPosition(
      target: LatLng(
          (30.85389579312156 + 30.750389209369917 + 30.95670425388353) / 3,
          (31.268433318547288 + 31.260458997797773 + 31.30646424602145) / 3),
      zoom: 12);

  static CameraPosition kGooglePlex2 = const CameraPosition(
    target: LatLng(31.056840273761154, 31.488563605540325),
    zoom: 9,
  );

  static final CameraPosition cameraPosition = CameraPosition(
      bearing: 0,
      target: LatLng(position.latitude, position.longitude),
      tilt: 0,
      zoom: 19.151926040649414);

  static Future<BitmapDescriptor> positionIcon() async {
    return await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      AssetManager.placeMarker,
    );
  }

  static Future<BitmapDescriptor> stationIcon() async {
    return await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      AssetManager.busStationMarker,
    );
  }

  static Future<BitmapDescriptor> busIcon() async {
    return await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(
  
      ),
      AssetManager.busIconTracking,
    );
  }

  static void addMarker(
      {required Set<Marker> marker,
      required LatLng latlng,
      required BitmapDescriptor icon,
      GestureTapCallback? onTap,
      double? rotation,
      Offset? anchor}) {
    marker.add(
      Marker(
        markerId: MarkerId(
          latlng.toString(),
        ),
        position: latlng, //position of marker
        onTap: onTap,
        icon: icon,
        rotation: rotation ?? 0.0,
        anchor: anchor ?? const Offset(0.5, 1.0),
      ),
    );
  }

  static double bearingBetweenLocations(LatLng latLng1, LatLng latLng2) {
    double PI = 3.14159;
    double lat1 = latLng1.latitude * PI / 180;
    double long1 = latLng1.longitude * PI / 180;
    double lat2 = latLng2.latitude * PI / 180;
    double long2 = latLng2.longitude * PI / 180;

    double dLon = (long2 - long1);

    double y = sin(dLon) * cos(lat2);
    double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);

    double brng = atan2(y, x);

    brng = brng * 180 / PI;
    brng = (brng + 360) % 360;

    return brng;
  }
}
