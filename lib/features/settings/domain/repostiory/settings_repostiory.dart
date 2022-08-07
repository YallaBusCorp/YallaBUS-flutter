import 'package:dartz/dartz.dart';
import '../entity/ride_history_model.dart';

import '../../../../core/states/state.dart';
import '../../../choose_company/domain/enitity/company.dart';
import '../../../sign_up/domain/enitity/student.dart';

abstract class SettingsRepostiory {
  Future<Either<Company, Failure>> getCompanyInfo(int id);
  Future<Either<List<RideHis>, Failure>> getNonScannedRides(int id);
  Future<Either<List<RideHis>, Failure>> getScannedRides(int id);
  Future<Either<Success, Failure>> update(Student student);
}
