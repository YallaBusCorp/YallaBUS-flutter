import 'package:yalla_bus/features/home/domain/enitity/appoinment.dart';

class RideHis {
  final int? id;
  final PickUp? pick;
  final DropOff? drop;
  final Appoint? appoinment;
  final String? busId;
  final String? emp;

  RideHis(this.id, this.pick, this.drop, this.appoinment, this.busId, this.emp);
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
