import 'package:yalla_bus/features/choose_company/domain/enitity/company.dart';
import 'package:yalla_bus/features/home/domain/enitity/appoinment.dart';

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
  MapPointsModel(
      {required int id,
      required String mapPointTitle,
      required double longitude,
      required double latitude})
      : super(
            id: id,
            mapPointTitle: mapPointTitle,
            longitude: longitude,
            latitude: latitude);
  factory MapPointsModel.fromJson(Map<String, dynamic> json) {
    return MapPointsModel(
        id: json['id'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        mapPointTitle: json['mapPointTitle']);
  }
}
