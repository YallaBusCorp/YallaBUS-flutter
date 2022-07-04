import 'package:dartz/dartz.dart';
import 'package:yalla_bus/features/settings/domain/entity/ride_history_model.dart';
import '../../../../core/states/state.dart';
import '../repostiory/settings_repostiory.dart';
import '../../../choose_company/domain/enitity/company.dart';

class GetScannedRides {
  final SettingsRepostiory repo;

  GetScannedRides(this.repo);

  Future<Either<List<RideHis>, Failure>> getScannedRides(int id) {
    return repo.getScannedRides(id);
  }
}