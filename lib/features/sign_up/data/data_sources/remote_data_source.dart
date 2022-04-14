
import 'package:dio/dio.dart';
import 'package:yalla_bus/core/exceptions/exception.dart';
import 'package:yalla_bus/core/resources/endpoints_manager.dart';
import 'package:yalla_bus/features/sign_up/data/model/complete_profile_converters.dart';
import 'package:yalla_bus/features/sign_up/domain/enitity/student.dart';

class CompleteProfileApiClient {
  late Dio dio;

  CompleteProfileApiClient() {
    dio = Dio(BaseOptions(baseUrl: ApiEndPoints.baseUrl));
  }

  Future<List<dynamic>> getUniversities(int companyId) async {
    try {
      Response response =
          await dio.get(ApiEndPoints.universitiesByCompanyId, queryParameters: {
        'id': companyId,
      });
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
      return response.data;
    } on DioError {
      throw ServerException();
    }
  }

  Future<int> postStudentInfo(Student student) async {
    final data = StudentModel(
      code: student.code,
      stdName: student.stdName,
      stdPhone: student.stdPhone,
      townId: student.townId,
      universityId: student.universityId,
      companyId: student.companyId,
    ).toJson();
    try {
      await dio.post(
        ApiEndPoints.saveStudentInfo,
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
      return 200;
    } on DioError  {
      throw ServerException();
    }
  }
}
