import 'package:dio/dio.dart';
import 'package:yalla_bus/core/resources/endpoints_manager.dart';

import '../../../../core/exceptions/exception.dart';

class BusMapApiClient {
  late Dio dio;

  BusMapApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndPoints.baseUrl,
      ),
    );
  }

  Future<bool> finishRide(int id) async {
    try {
      Response response = await dio.put(ApiEndPoints.endRide, queryParameters: {
        'id': id,
      });
      return response.data;
    } on DioError {
      throw ServerException();
    }
  }
}
