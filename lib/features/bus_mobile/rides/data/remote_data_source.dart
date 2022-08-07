import 'package:dio/dio.dart';
import '../../../../core/exceptions/exception.dart';
import '../../../../core/resources/endpoints_manager.dart';

import '../../../../core/resources/debugger_manager.dart';

class BusRideApiClient {
  late Dio dio;
  BusRideApiClient() {
    dio = Dio(BaseOptions(
      baseUrl: ApiEndPoints.baseUrl,
    ));
    dio.interceptors.add(DebuggerManager.alice.getDioInterceptor());
  }
  Future<List<dynamic>> getCurrentRideByBusUid(String busUid) async {
    try {
      Response response =
          await dio.get(ApiEndPoints.getCurrentRideByBusUid, queryParameters: {
        'uId': busUid,
      });
      return response.data;
    } on DioError {
      throw ServerException();
    }
  }
}
