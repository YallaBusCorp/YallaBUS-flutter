class Ride {
  final String qrCode;
  final PickUpPoint pickupPoint;
  final DropOffPoint dropOffPoint;
  final Appointments appointment;
  final StudentID std;

  Ride(
      {required this.qrCode,
      required this.pickupPoint,
      required this.dropOffPoint,
      required this.appointment,
      required this.std});
}

class PickUpPoint {
  final int id;

  PickUpPoint(this.id);
}

class DropOffPoint {
  final int id;

  DropOffPoint(this.id);
}

class Appointments {
  final int id;

  Appointments(this.id);
}

class StudentID {
  final int id;
  StudentID(this.id);
}
