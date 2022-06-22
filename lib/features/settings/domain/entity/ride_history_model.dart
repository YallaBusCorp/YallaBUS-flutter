import 'package:yalla_bus/features/home/domain/enitity/appoinment.dart';

class RideHis {
  final PickUp pick;
  final DropOff drop;
  final Appoint appoinment;
  final String busId;
  final String emp;

  RideHis(
      {required this.pick,
      required this.drop,
      required this.appoinment,
      required this.busId,
      required this.emp});
}

class PickUp {
  final String name;

  PickUp({required this.name});
}

class DropOff {
  final String name;

  DropOff({required this.name});
}

class Appoint {
  final String date;
  final String amOrPm;

  Appoint({required this.date, required this.amOrPm});
}
