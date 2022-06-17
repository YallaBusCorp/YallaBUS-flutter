import 'package:yalla_bus/features/home/domain/enitity/ride.dart';

import '../../../choose_company/domain/enitity/company.dart';
import '../../domain/enitity/appoinment.dart';

import '../../domain/enitity/map_point.dart';

class AppointmentModel extends Appoinment {
  AppointmentModel({
    required int id,
    required String appointmentStartTime,
    required String appointmentType,
  }) : super(
          id: id,
          appointmentStartTime: appointmentStartTime,
          appointmentType: appointmentType,
        );

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
      appointmentStartTime: json['appointmentStartTime'],
      appointmentType: json['appointmentType'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['appointmentStartTime'] = appointmentStartTime;
    data['appointmentType'] = appointmentType;
    return data;
  }
}

class MapPointsModel extends MapPoint {
  MapPointsModel({
    required int id,
    required double longitude,
    required double latitude,
    required String mapPointTitleEn,
    required String mapPointTitleAr,
  }) : super(
            id: id,
            mapPointTitleEn: mapPointTitleEn,
            mapPointTitleAr: mapPointTitleAr,
            longitude: longitude,
            latitude: latitude);
  factory MapPointsModel.fromJson(Map<String, dynamic> json) {
    return MapPointsModel(
        id: json['id'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        mapPointTitleEn: json['mapPointTitleEn'],
        mapPointTitleAr: json['mapPointTitleAr']);
  }
}

class RideModel extends Ride {
  RideModel(String qrCode, PickUpPoint pickupPoint, DropOffPoint dropOffPoint,
      Appointments appointment, StudentID std)
      : super(
            qrCode: qrCode,
            pickupPoint: pickupPoint,
            dropOffPoint: dropOffPoint,
            appointment: appointment,
            std: std);

  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
        json['qrCode'],
        PickUpPointModel.fromJson(json['pickupPoint']),
        DropOffPointModel.fromJson(json['dropoffPoint']),
        AppointmentsModel.fromJson(json['appointment']),
        json['std']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['qrCode'] = qrCode;
    data['pickupPoint'] = PickUpPointModel(pickupPoint.id).toJson();
    data['dropoffPoint'] = DropOffPointModel(dropOffPoint.id).toJson();
    data['appointment'] = AppointmentsModel(appointment.id).toJson();
    data['std'] = StudentIdModel(std.id).toJson();
    return data;
  }
}

class PickUpPointModel extends PickUpPoint {
  PickUpPointModel(int id) : super(id);
  factory PickUpPointModel.fromJson(Map<String, dynamic> json) {
    return PickUpPointModel(json['id']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}

class DropOffPointModel extends DropOffPoint {
  DropOffPointModel(int id) : super(id);
  factory DropOffPointModel.fromJson(Map<String, dynamic> json) {
    return DropOffPointModel(json['id']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}

class AppointmentsModel extends Appointments {
  AppointmentsModel(int id) : super(id);
  factory AppointmentsModel.fromJson(Map<String, dynamic> json) {
    return AppointmentsModel(json['id']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}

class StudentIdModel extends StudentID {
  StudentIdModel(int id) : super(id);
  factory StudentIdModel.fromJson(Map<String, dynamic> json) {
    return StudentIdModel(json['id']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
