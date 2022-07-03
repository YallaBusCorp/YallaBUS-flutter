import 'package:yalla_bus/features/home/domain/enitity/ride.dart';

class Reschedule {
  final int id;
  final String qrCode;
  final Appointments appointments;

  Reschedule(this.id, this.qrCode, this.appointments);
}
