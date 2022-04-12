import 'package:dio/dio.dart';
import 'package:yalla_bus/core/exceptions/exception.dart';
import 'package:yalla_bus/core/resources/endpoints_manager.dart';

class CompleteProfileApiClient {
  late Dio dio;

  CompleteProfileApiClient() {
    dio = Dio(BaseOptions(
      baseUrl: ApiEndPoints.baseUrl,
    ));
  }

  Future<List<dynamic>> getUniversities(int companyId) async {
    try {
      Response response =
          await dio.get(ApiEndPoints.universitiesByCompanyId, queryParameters: {
        'id': companyId,
      });
      print(response.data);
      return response.data;
    } on DioError {
      throw ServerException();
    }
  }

  Future<List<dynamic>> getTowns(int companyId) async {
    try {
      Response response =
          await dio.get(ApiEndPoints.townsByCompanyId, queryParameters: {
        'id': companyId,
      });
      print(response.data);
      return response.data;
    } on DioError {
      throw ServerException();
    }
  }
}
