import '../../../home/domain/enitity/appoinment.dart';

class RideHis {
  final int? id;
  final String? qrCode;
  final PickUp? pick;
  final DropOff? drop;
  final Appoint? appoinment;
  final Bus? bus;
  final Employee? emp;
  final TxRide? txRide;

  RideHis(this.id, this.qrCode, this.pick, this.drop, this.appoinment, this.bus,
      this.emp, this.txRide);
}

class PickUp {
  final String name;
  final double longitude;
  final double latitude;

  PickUp(this.name, this.latitude, this.longitude);
}

class DropOff {
  final String name;
  final double longitude;
  final double latitude;
  DropOff(this.name, this.latitude, this.longitude);
}

class Appoint {
  final String date;
  final String amOrPm;

  Appoint(this.date, this.amOrPm);
}

class Bus {
  final int id;
  final String busUid;
  final String phone;
  final String busLicenceNumber;

  Bus(this.id, this.busUid, this.phone, this.busLicenceNumber);
}

class Employee {
  final int id;
  final CompanyId company;
  final String empCode;
  final String empName;

  Employee(this.id, this.company, this.empCode, this.empName);
}

class TxRide {
  final int id;
  final String rideStatus;

  TxRide(this.id, this.rideStatus);
}

class CompanyId {
  final int id;

  CompanyId(this.id);
}
