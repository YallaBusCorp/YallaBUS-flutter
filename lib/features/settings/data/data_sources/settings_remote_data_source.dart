import 'package:dio/dio.dart';
import 'package:yalla_bus/core/exceptions/exception.dart';
import 'package:yalla_bus/features/sign_up/data/model/complete_profile_converters.dart';
import 'package:yalla_bus/features/sign_up/domain/enitity/student.dart';
import '../../../../core/resources/debugger_manager.dart';
import '../../../../core/resources/endpoints_manager.dart';
import '../../../../core/states/state.dart';

class SettingsApiClient {
  late Dio dio;
  SettingsApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndPoints.baseUrl,
      ),
    );
    dio.interceptors.add(DebuggerManager.alice.getDioInterceptor());
  }

  Future<dynamic> getCompanyInfo(int id) async {
    Response response =
        await dio.get(ApiEndPoints.companyId, queryParameters: {'id': id});
    return response.data;
  }

  Future<Success> update(Student student) async {
    final data = StudentModel(
            stdUid: student.stdUid,
            stdName: student.stdName,
            stdPhone: student.stdPhone,
            companyId: student.companyId,
            townId: student.townId,
            universityId: student.universityId)
        .toJson();
    try {
      Response response = await dio.put(
        ApiEndPoints.updateStudent,
        data: data,
      );
      return Success();
    } on DioError {
      throw ServerException();
    }
  }

  Future<List<dynamic>> getNonScannedRides(int id) async {
    final data = {
      'id': id,
    };
    try {
      Response response = await dio.get(
        ApiEndPoints.getNonScannedRides,
        queryParameters: data,
      );
      return response.data;
    } on DioError  {
      throw ServerException();
    }
  }

  Future<List<dynamic>> getScannedRides(int id) async {
    final data = {
      'id': id,
    };
    try {
      Response response = await dio.get(
        ApiEndPoints.getNonScannedRides,
        queryParameters: data,
      );
      return response.data;
    } on DioError  {
      throw ServerException();
    }
  }
}
