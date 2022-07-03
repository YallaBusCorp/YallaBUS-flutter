import 'package:yalla_bus/features/settings/domain/entity/ride_history_model.dart';

class RideHisModel extends RideHis {
  RideHisModel(int id, String qrCode, PickUp pick, DropOff drop,
      Appoint appoinment, Bus bus, Employee emp, TxRide txRide)
      : super(id, qrCode, pick, drop, appoinment, bus, emp, txRide);

  factory RideHisModel.fromJson(Map<String, dynamic> json) {
    return RideHisModel(
        json['id'] ?? -1,
        json['qrCode'] ?? '08:00AMOsdafosdgsdag',
        PickUpModel.fromJson(json['pickupPoint'] ??
            {
              'mapPointTitleEn': 'name',
              'latitude': 40.324325,
              'longitude': 50.436643
            }),
        DropOffModel.fromJson(json['dropoffPoint'] ??
            {
              'mapPointTitleEn': 'name',
              'latitude': 40.324325,
              'longitude': 50.436643
            }),
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
              'id': 1,
              'company' : {
                'id' : 1,
              },
              'empName': 'TTTTTTTT',
              'empCode': '6735',
            }),
        TxRideModel.fromJson(json['txRide'] ??
            {
              'id': 1,
              'rideStatus': 'complete',
            }));
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['emp'] = EmployeeModel(emp!.id,emp!.company ,emp!.empCode,  emp!.empName);
    data['pickupPoint'] =
        PickUpModel(pick!.name, pick!.latitude, pick!.longitude).toJson();
    data['dropoffPoint'] =
        DropOffModel(pick!.name, pick!.latitude, pick!.longitude).toJson();
    data['appointment'] =
        AppointModel(appoinment!.date, appoinment!.amOrPm).toJson();
    data['bus'] =
        BusModel(bus!.id, bus!.busUid, bus!.phone, bus!.busLicenceNumber);
    data['txRide'] = TxRideModel(txRide.id, txRide.rideStatus);
    return data;
  }
}

class PickUpModel extends PickUp {
  PickUpModel(String name, double latituide, double longitude)
      : super(
          name,
          latituide,
          longitude,
        );
  factory PickUpModel.fromJson(Map<String, dynamic> json) {
    return PickUpModel(
        json['mapPointTitleEn'], json['latitude'], json['longitude']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mapPointTitleEn'] = name;
    data['latitude'] = latitude;
    data['longitude'] = longitude;

    return data;
  }
}

class DropOffModel extends DropOff {
  DropOffModel(String name, double latituide, double longitude)
      : super(
          name,
          latituide,
          longitude,
        );
  factory DropOffModel.fromJson(Map<String, dynamic> json) {
    return DropOffModel(
        json['mapPointTitleEn'], json['latitude'], json['longitude']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mapPointTitleEn'] = name;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
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
class CompanyIdModel extends CompanyId{
  CompanyIdModel(int id) : super(id);
  factory CompanyIdModel.fromJson(Map<String, dynamic> json) {
    return CompanyIdModel(json['id']);
  }

   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
class EmployeeModel extends Employee {
  EmployeeModel(int id, CompanyId company, String empCode, String empName)
      : super(id, company, empCode, empName);

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(json['id'],CompanyIdModel.fromJson(json['company']), json['empCode'], json['empName']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company'] = CompanyIdModel(id).toJson();
    data['empCode'] = empCode;
    data['empName'] = empName;

    return data;
  }
}
 

class TxRideModel extends TxRide {
  TxRideModel(int id, String rideStatus) : super(id, rideStatus);

  factory TxRideModel.fromJson(Map<String, dynamic> json) {
    return TxRideModel(json['id'], json['rideStatus']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rideStatus'] = rideStatus;

    return data;
  }
}
