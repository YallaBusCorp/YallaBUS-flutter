import 'package:dio/dio.dart';
import '../../../../core/exceptions/exception.dart';
import '../../../../core/resources/debugger_manager.dart';
import '../../../../core/resources/endpoints_manager.dart';

class CompaniesApiClient {
  late Dio dio;

  CompaniesApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndPoints.baseUrl,
      ),
    );
    dio.interceptors.add(DebuggerManager.alice.getDioInterceptor());
  }

  Future<List<dynamic>> getCompaniesInformation() async {
    try {
      Response response = await dio.get(ApiEndPoints.companies);
      return response.data;
    } on DioError {
      throw ServerException();
    }
  }
}
