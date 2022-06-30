import 'package:dio/dio.dart';
import 'package:yalla_bus/core/resources/endpoints_manager.dart';

import '../../../../core/exceptions/exception.dart';

class EmployeeApiClient {
  late Dio dio;

  EmployeeApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndPoints.baseUrl,
      ),
    );
  }

  Future<dynamic> getBusUid(int number) async {

    try {
      Response response =
          await dio.get(ApiEndPoints.getBusUid, queryParameters: {
        'phone': number,
      });

      return response.data;
    } on DioError {
      throw ServerException();
    }
  }
}
