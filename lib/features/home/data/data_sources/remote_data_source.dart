import 'package:dio/dio.dart';
import '../../../../core/resources/debugger_manager.dart';
import '../model/map_json_converters.dart';
import '../../../../core/exceptions/exception.dart';
import '../../../../core/resources/endpoints_manager.dart';
import '../../domain/enitity/reschedule_body.dart';
import '../../domain/enitity/ride.dart';

class MapApiClient {
  late Dio dio;

  MapApiClient() {
    dio = Dio(BaseOptions(
      baseUrl: ApiEndPoints.baseUrl,
    ));
    dio.interceptors.add(DebuggerManager.alice.getDioInterceptor());
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
    final data = RideModel(ride.qrCode, ride.pickupPoint, ride.dropOffPoint,
            ride.appointment, ride.std)
        .toJson();
    try {
      Response response = await dio.post(
        ApiEndPoints.bookRide,
        data: data,
      );
      return response.data['id'];
    } on DioError catch (e) {
      throw ServerException();
    }
  }

  Future<dynamic> getCurrentRideByUID(String uid) async {
    try {
      Response response = await dio.get(
        ApiEndPoints.getCurrentRideByUID,
        queryParameters: {
          'uId': uid,
        },
      );
      if (response.data.toString().isEmpty) {
        return 500;
      } else {
        return response.data;
      }
    } on DioError {
      throw ServerException();
    }
  }

  Future<bool> cancelRide(int bookingId) async {
    try {
      Response response = await dio.delete(
        ApiEndPoints.cancelRide,
        queryParameters: {
          'id': bookingId,
        },
      );
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      print(e.message);
      throw ServerException();
    }
  }

  Future<dynamic> getStudentId(String uid) async {
    try {
      Response response =
          await dio.get(ApiEndPoints.getStudentID, queryParameters: {
        'stdUid': uid,
      });
      print(response.data);
      print('++++++++++');
      print(response.data['id']);
      return response.data;
    } on DioError catch (e) {
      print(e.message);
      throw ServerException();
    }
  }

  Future<dynamic> rescheduleRide(Reschedule r) async {
    final data =
        RescheduleModel(r.id, r.qrCode, Appointments(r.appointments.id))
            .toJson();
    try {
      Response response =
          await dio.put(ApiEndPoints.rescheduleRide, data: data);
      return response.data;
    } on DioError catch (e) {
      print(e.message);
      throw ServerException();
    }
  }
}
