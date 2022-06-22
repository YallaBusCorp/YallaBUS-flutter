import 'package:yalla_bus/features/settings/domain/entity/ride_history_model.dart';

class RideHisModel extends RideHis {
  RideHisModel(int id, PickUp pick, DropOff drop, Appoint appoinment,
      String busId, String emp)
      : super(id, pick, drop, appoinment, busId, emp);

  factory RideHisModel.fromJson(Map<String, dynamic> json) {
    return RideHisModel(
        json['id'] ?? -1,
        PickUpModel.fromJson(
            json['pickupPoint'] ?? {'mapPointTitleEn': 'name'}),
        DropOffModel.fromJson(
            json['dropoffPoint'] ?? {'mapPointTitleEn': 'name'}),
        AppointModel.fromJson(json['appointment'] ??
            {'appointmentStartTime': '05:52:00', 'appointmentType': 'AM'}),
        json['bus'] ?? 'ABC | 4444',
        json['emp'] ?? 'Abdo Abdo');
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['emp'] = emp;
    data['pickupPoint'] = PickUpModel(pick!.name).toJson();
    data['dropoffPoint'] = DropOffModel(pick!.name).toJson();
    data['appointment'] =
        AppointModel(appoinment!.date, appoinment!.amOrPm).toJson();
    data['bus'] = busId;

    return data;
  }
}

class PickUpModel extends PickUp {
  PickUpModel(String name) : super(name);
  factory PickUpModel.fromJson(Map<String, dynamic> json) {
    return PickUpModel(json['mapPointTitleEn']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mapPointTitleEn'] = name;

    return data;
  }
}

class DropOffModel extends DropOff {
  DropOffModel(String name) : super(name);
  factory DropOffModel.fromJson(Map<String, dynamic> json) {
    return DropOffModel(json['mapPointTitleEn']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mapPointTitleEn'] = name;

    return data;
  }
}

class AppointModel extends Appoint {
  AppointModel(String date, String amOrPm) : super(date, amOrPm);

  factory AppointModel.fromJson(Map<String, dynamic> json) {
    return AppointModel(
      json['appointmentStartTime'],
      json['appointmentType']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appointmentStartTime'] = date;
    data['appointmentType'] = amOrPm;

    return data;
  }
}
