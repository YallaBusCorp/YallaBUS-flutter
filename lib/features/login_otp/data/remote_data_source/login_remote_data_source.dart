import 'dart:convert';

import 'package:dio/dio.dart';
import '../../../../core/exceptions/exception.dart';
import '../../../../core/resources/endpoints_manager.dart';

class LoginApiClient {
  late Dio dio;
  LoginApiClient() {
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
