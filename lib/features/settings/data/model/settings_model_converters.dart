import 'package:yalla_bus/features/settings/domain/entity/ride_history_model.dart';

class RideHisModel extends RideHis {
  RideHisModel(int id, PickUp pick, DropOff drop, Appoint appoinment, Bus bus,
      Employee emp)
      : super(id, pick, drop, appoinment, bus, emp);

  factory RideHisModel.fromJson(Map<String, dynamic> json) {
    return RideHisModel(
      json['id'] ?? -1,
      PickUpModel.fromJson(json['pickupPoint'] ?? {'mapPointTitleEn': 'name'}),
      DropOffModel.fromJson(
          json['dropoffPoint'] ?? {'mapPointTitleEn': 'name'}),
      AppointModel.fromJson(json['appointment'] ??
          {'appointmentStartTime': '05:52:00', 'appointmentType': 'AM'}),
      BusModel.fromJson(json['bus'] ??
          {
            'id': 1,
            'busUid': "8888",
            'phone': "01010101010101",
            'busLicenceNumber': '1 9 2 | ح ب ي ',
          }),
      EmployeeModel.fromJson(json['emp'] ??
          {
            'empName': 'Abdo Mohamed',
            'empCode': "6735",
          }),
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['emp'] = EmployeeModel(emp!.empCode, emp!.empName);
    data['pickupPoint'] = PickUpModel(pick!.name).toJson();
    data['dropoffPoint'] = DropOffModel(pick!.name).toJson();
    data['appointment'] =
        AppointModel(appoinment!.date, appoinment!.amOrPm).toJson();
    data['bus'] = BusModel(bus!.id, bus!.busUid, bus!.phone, bus!.busLicenceNumber);

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
    return AppointModel(json['appointmentStartTime'], json['appointmentType']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appointmentStartTime'] = date;
    data['appointmentType'] = amOrPm;

    return data;
  }
}

class BusModel extends Bus {
  BusModel(int id, String busUid, String phone, String busLicenceNumber)
      : super(id, busUid, phone, busLicenceNumber);

  factory BusModel.fromJson(Map<String, dynamic> json) {
    return BusModel(
        json['id'], json['busUid'], json['phone'], json['busLicenceNumber']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['busUid'] = busUid;
    data['phone'] = phone;
    data['busLicenceNumber'] = busLicenceNumber;

    return data;
  }
}

class EmployeeModel extends Employee {
  EmployeeModel(String empCode, String empName) : super(empCode, empName);

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(json['empCode'], json['empName']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['empCode'] = empCode;
    data['empName'] = empName;

    return data;
  }
}
