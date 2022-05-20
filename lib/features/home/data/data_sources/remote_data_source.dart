import 'package:dio/dio.dart';
import '../../../../core/exceptions/exception.dart';
import '../../../../core/resources/endpoints_manager.dart';
import '../../domain/enitity/ride.dart';

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
      return response.data;
    } on DioError {
      throw ServerException();
    }
  }

  Future<int> bookRide(Ride ride) async {
    final data = Ride(ride.qrCode, ride.pickupPoint, ride.dropOffPoint,
        ride.appointment, ride.std);
    try {
      Response response = await dio.post(
        ApiEndPoints.bookRide,
        data: data,
      );
      print(response.data);
      return 200;
    } on DioError {
      throw ServerException();
    }
  }

  Future<int> getStudentId(String uid) async {
    try {
      Response response = await dio.get(
        ApiEndPoints.getStudentByUID,
        queryParameters: {
          'stdUid': uid,
        },
      );
      print(response.data['id']);
      return response.data['id'];
    } on DioError {
      throw ServerException();
    }
  }
}
