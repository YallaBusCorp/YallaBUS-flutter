import 'package:dio/dio.dart';
import '../../../../core/resources/endpoints_manager.dart';

import '../../../../core/exceptions/exception.dart';
import '../../../../core/resources/debugger_manager.dart';

class BusMapApiClient {
  late Dio dio;

  BusMapApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndPoints.baseUrl,
      ),
    );
    dio.interceptors.add(DebuggerManager.alice.getDioInterceptor());
  }

  Future<bool> finishRide(int id) async {
    try {
      Response response = await dio.put(ApiEndPoints.endRide, queryParameters: {
        'id': id,
      });
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } on DioError {
      throw ServerException();
    }
  }
}
