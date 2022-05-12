import 'package:dio/dio.dart';
import 'package:yalla_bus/core/resources/endpoints_manager.dart';

class SettingsApiClient {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiEndPoints.baseUrl,
    ),
  );

  Future<dynamic> getCompanyInfo(int id) async {
    Response response =
        await dio.get(ApiEndPoints.companyId, queryParameters: {'id': id});
    return response.data;
  }
}
