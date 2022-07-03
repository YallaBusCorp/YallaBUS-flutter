import 'package:dartz/dartz.dart';
import 'package:yalla_bus/features/home/domain/enitity/reschedule_body.dart';
import 'package:yalla_bus/features/home/domain/enitity/ride.dart';
import 'package:yalla_bus/features/home/domain/repository/map_repository.dart';
import 'package:yalla_bus/features/settings/domain/entity/ride_history_model.dart';
import '../../../../core/states/state.dart';
import '../../../sign_up/domain/repository/complete_profile_repository.dart';

class RescheduleRide {
  final MapRepository repo;

  RescheduleRide(this.repo);
  Future<Either<Failure, RideHis>> rescheduleRide(Reschedule r) async {
    return await repo.rescheduleRide(r);
  }
}
