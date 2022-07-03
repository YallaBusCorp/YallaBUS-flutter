import '../../../settings/domain/entity/ride_history_model.dart';

class ReturenedRide {
  final int? id;
  final String? status;
  final Appoint? appoinment;
  final Bus? bus;
  final Employee? emp;

  ReturenedRide(this.id, this.status, this.appoinment,
      this.bus, this.emp);
}
