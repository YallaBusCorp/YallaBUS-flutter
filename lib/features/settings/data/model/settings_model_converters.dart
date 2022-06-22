import 'package:yalla_bus/features/settings/domain/entity/ride_history_model.dart';

class RideHisModel extends RideHis {
  RideHisModel(
      {required PickUp pick,
      required DropOff drop,
      required Appoint appoinment,
      required String busId,
      required String emp})
      : super(
            pick: pick,
            drop: drop,
            appoinment: appoinment,
            busId: busId,
            emp: emp);

  factory RideHisModel.fromJson(Map<String, dynamic> json) {
    return RideHisModel(
        pick: PickUpModel.fromJson(json['pickupPoint']),
        drop: DropOffModel.fromJson(json['dropoffPoint']),
        appoinment: AppointModel.fromJson(json['appointment']),
        busId: json['bus'] ?? 'ABC | 4444',
        emp: json['emp'] ?? 'Abdo Abdo');
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['emp'] = emp;
    data['pickupPoint'] = PickUpModel(name: pick.name).toJson();
    data['dropoffPoint'] = DropOffModel(name: pick.name).toJson();
    data['appointment'] =
        AppointModel(date: appoinment.date, amOrPm: appoinment.amOrPm).toJson();
    data['bus'] = busId;

    return data;
  }
}

class PickUpModel extends PickUp {
  PickUpModel({required String name}) : super(name: name);
  factory PickUpModel.fromJson(Map<String, dynamic> json) {
    return PickUpModel(name: json['mapPointTitleEn']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mapPointTitleEn'] = name;

    return data;
  }
}

class DropOffModel extends DropOff {
  DropOffModel({required String name}) : super(name: name);
  factory DropOffModel.fromJson(Map<String, dynamic> json) {
    return DropOffModel(name: json['mapPointTitleEn']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mapPointTitleEn'] = name;

    return data;
  }
}

class AppointModel extends Appoint {
  AppointModel({required String date, required String amOrPm})
      : super(date: date, amOrPm: amOrPm);

  factory AppointModel.fromJson(Map<String, dynamic> json) {
    return AppointModel(
        date: json['appointmentStartTime'], amOrPm: json['appointmentType']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appointmentStartTime'] = date;
    data['amOrPm'] = amOrPm;

    return data;
  }
}
