import 'package:yalla_bus/features/home/domain/enitity/appoinment.dart';

class RideHis {
  final int? id;
  final PickUp? pick;
  final DropOff? drop;
  final Appoint? appoinment;
  final Bus? bus;
  final Employee? emp;

  RideHis(this.id, this.pick, this.drop, this.appoinment, this.bus, this.emp);
}

class PickUp {
  final String name;

  PickUp(this.name);
}

class DropOff {
  final String name;

  DropOff(this.name);
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
  final String empCode;
  final String empName;

  Employee(this.empCode, this.empName);
}
