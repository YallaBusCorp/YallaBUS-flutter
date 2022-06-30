import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yalla_bus/core/resources/endpoints_manager.dart';

import '../../../../core/exceptions/exception.dart';

class CoordinateApiClient {
  late Dio dio;

  CoordinateApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://router.project-osrm.org/route/v1/',
      ),
    );
  }

  Future<List<LatLng>> getAllCoordinates(LatLng a, LatLng b) async {
    List<LatLng> routepoints = [];
    try {
      Response response = await dio.get(
          'driving/${a.longitude},${a.latitude};${b.longitude},${b.latitude}',
          queryParameters: {
            'geometries': 'geojson',
          });
      var rutar =
          response.data["routes"][0]["geometry"]["coordinates"];
      for (int i = 0; i < rutar.length; i++) {
        var reep = rutar[i].toString();
        reep = reep.replaceAll("[", "");
        reep = reep.replaceAll("]", "");
        var lat1 = reep.split(',');
        var long1 = reep.split(',');
        routepoints.add(LatLng(double.parse(lat1[1]), double.parse(long1[0])));
      }
      return routepoints;
    } on DioError {
      throw ServerException();
    }
  }
}
