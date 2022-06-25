import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:yalla_bus/core/exceptions/exception.dart';
import 'package:yalla_bus/core/resources/endpoints_manager.dart';

class LoginApiClient {
  late Dio dio;
  LoginApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndPoints.baseUrl,
      ),
    );
  }
  
}
