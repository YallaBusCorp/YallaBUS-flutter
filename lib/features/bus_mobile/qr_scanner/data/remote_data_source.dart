import 'package:dio/dio.dart';
import 'package:yalla_bus/core/exceptions/exception.dart';
import 'package:yalla_bus/core/resources/endpoints_manager.dart';

class BusQrApiClient {
  late Dio dio;
  BusQrApiClient() {
    dio = Dio(BaseOptions(
      baseUrl: ApiEndPoints.baseUrl,
    ));
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
