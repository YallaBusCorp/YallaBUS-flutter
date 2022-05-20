import 'package:dio/dio.dart';
import '../../../../core/exceptions/exception.dart';
import '../../../../core/resources/endpoints_manager.dart';

class MapApiClient {
  late Dio dio;

  MapApiClient() {
    dio = Dio(BaseOptions(
      baseUrl: ApiEndPoints.baseUrl,
    ));
  }

  Future<List<dynamic>> getAppointmentsAM(int id) async {
    try {
      Response response =
          await dio.get(ApiEndPoints.appointmentAm, queryParameters: {
        'id': id,
      });

      return response.data;
    } on DioError {
      throw ServerException();
    }
  }

  Future<List<dynamic>> getAppointmentsPM(int id) async {
    try {
      Response response =
          await dio.get(ApiEndPoints.appointmentPm, queryParameters: {
        'id': id,
      });

      return response.data;
    } on DioError {
      throw ServerException();
    }
  }

  Future<List<dynamic>> getMapPickUpPoints(int id) async {
    try {
      Response response =
          await dio.get(ApiEndPoints.mapPointsPickUp, queryParameters: {
        'id': id,
      });
      print(response.data);
      return response.data;
    } on DioError {
      throw ServerException();
    }
  }

  Future<List<dynamic>> getMapDropOffPoints(int id) async {
    try {
      Response response =
          await dio.get(ApiEndPoints.mapPointsDropDown, queryParameters: {
        'id': id,
      });
      print(response.data);
      return response.data;
    } on DioError {
      throw ServerException();
    }
  }
}
