import 'package:dartz/dartz.dart';

import '../../../../core/states/state.dart';
import '../entity/ride_history_model.dart';
import '../repostiory/settings_repostiory.dart';

class GetScannedRides {
  final SettingsRepostiory repo;

  GetScannedRides(this.repo);

  Future<Either<List<RideHis>, Failure>> getScannedRides(int id) {
    return repo.getScannedRides(id);
  }
}
