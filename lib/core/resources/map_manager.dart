import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';

class MapManager {
  static Completer<GoogleMapController> controller = Completer();

  static Location location = Location();
  static late LocationData myLocation;

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
      target: LatLng(myLocation.latitude!, myLocation.longitude!),
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
      const ImageConfiguration(
        devicePixelRatio: 2.5,
      ),
      AssetManager.busStationMarker,
    );
  }

  static Future<BitmapDescriptor> busIcon() async {
    return await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(
        devicePixelRatio: 2.5,
      ),
      AssetManager.busIconTracking,
    );
  }

  static void addMarker(
      {required int id,
      required Set<Marker> marker,
      required LatLng latlng,
      required BitmapDescriptor icon,
      GestureTapCallback? onTap,
      double? rotation,
      Offset? anchor}) {
    marker.add(
      Marker(
        markerId: MarkerId(
          id.toString(),
        ),
        position: latlng, //position of marker
        onTap: onTap,
        icon: icon,
    
        anchor: const Offset(0.5, 0.5),
      ),
    );
  }

  static Future<BitmapDescriptor> bitmapDescriptorFromSvgAsset(BuildContext context, String assetName) async {
    // Read SVG file as String
    String svgString = await DefaultAssetBundle.of(context).loadString(assetName);
    // Create DrawableRoot from SVG String
    DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString,'');

    // toPicture() and toImage() don't seem to be pixel ratio aware, so we calculate the actual sizes here
    MediaQueryData queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;
    double width = 64 * devicePixelRatio; // where 32 is your SVG's original width
    double height = 64 * devicePixelRatio; // same thing

    // Convert to ui.Picture
    ui.Picture picture = svgDrawableRoot.toPicture(size: Size(width, height));

    // Convert to ui.Image. toImage() takes width and height as parameters
    // you need to find the best size to suit your needs and take into account the
    // screen DPI
    ui.Image image = await picture.toImage(width.toInt(), height.toInt());
    ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
}

  static void removeMarker({required Marker m, required Set<Marker> marker}) {
    marker.remove(m);
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
