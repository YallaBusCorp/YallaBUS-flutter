import 'package:dartz/dartz.dart';
import 'package:yalla_bus/features/home/domain/enitity/returned_ride.dart';

import '../../../../core/states/state.dart';
import '../../../settings/domain/entity/ride_history_model.dart';
import '../enitity/appoinment.dart';
import '../enitity/ride.dart';
import '../repository/map_repository.dart';

class GetCurrentRide {
  final MapRepository repo;

  GetCurrentRide(this.repo);
  Future<Either<Failure, ReturenedRide>> getCurrentRideByUID(String uid) async {
    return await repo.getCurrentRide(uid);
  }
}
