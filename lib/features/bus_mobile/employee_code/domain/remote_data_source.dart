import 'package:dio/dio.dart';
import '../../../../core/resources/endpoints_manager.dart';
import '../../../../core/states/state.dart';

import '../../../../core/exceptions/exception.dart';
import '../../../../core/resources/debugger_manager.dart';

class EmployeeApiClient {
  late Dio dio;

  EmployeeApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndPoints.baseUrl,
      ),
    );
    dio.interceptors.add(DebuggerManager.alice.getDioInterceptor());
  }

  Future<dynamic> getEmployee(String code) async {
    try {
      Response response =
          await dio.get(ApiEndPoints.getEmployeeByCode, queryParameters: {
        'empCode': code,
      });
      return response.data;
    } on DioError {
      throw ServerException();
    }
  }

  Future<dynamic> getCompanyName(int id) async {
    try {
      Response response =
          await dio.get(ApiEndPoints.companyId, queryParameters: {
        'id': id,
      });
      return response.data['companyName'];
    } on DioError {
      throw ServerException();
    }
  }

  Future<int> saveTxRide(int empId, int busId) async {
    final data = {
      'emp': {
        'id': empId,
      },
      'bus': {
        'id': busId,
      },
    };
    try {
      Response response = await dio.post(ApiEndPoints.saveTxRide, data: data);
      return 200;
    } on DioError catch (e) {
      throw ServerException();
    }
  }
}
