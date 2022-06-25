import 'package:dio/dio.dart';
import '../../../../core/exceptions/exception.dart';
import '../../../../core/resources/endpoints_manager.dart';
import '../model/complete_profile_converters.dart';
import '../../domain/enitity/student.dart';

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
      stdUid: student.stdUid,
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
    } on DioError catch (e) {
      print(e.message);
      throw ServerException();
    }
  }

  Future<int> getStudentId(String uid) async {
    print(uid);
    try {
      Response response =
          await dio.get(ApiEndPoints.getStudentID, queryParameters: {
        'stdUid': uid,
      });
      print(response.data);
      print('++++++++++');
      print(response.data['id']);
      return response.data['id'];
    } on DioError {
      throw ServerException();
    }
  }
}
