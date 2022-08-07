import 'package:dartz/dartz.dart';

import '../../../../core/states/state.dart';
import '../../../settings/domain/entity/ride_history_model.dart';
import '../repository/map_repository.dart';

class GetCurrentRide {
  final MapRepository repo;

  GetCurrentRide(this.repo);
  Future<Either<Failure, RideHis>> getCurrentRideByUID(String uid) async {
    return await repo.getCurrentRide(uid);
  }
}
