import 'package:dio/dio.dart';
import '../../../../core/exceptions/exception.dart';
import '../../../../core/resources/endpoints_manager.dart';

import '../../../../core/resources/debugger_manager.dart';

class BusQrApiClient {
  late Dio dio;
  BusQrApiClient() {
    dio = Dio(BaseOptions(
      baseUrl: ApiEndPoints.baseUrl,
    ));
    dio.interceptors.add(DebuggerManager.alice.getDioInterceptor());
  }
  Future<String> scanQr(String qrCode, int busId) async {
    try {
      Response response = await dio.get(ApiEndPoints.scanQr, queryParameters: {
        'qrCode': qrCode,
        'busId': busId,
      });
      return response.data;
    } on DioError {
      throw ServerException();
    }
  }
}
