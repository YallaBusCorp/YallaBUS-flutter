import 'package:dartz/dartz.dart';
import '../../../../core/states/state.dart';
import '../enitity/appoinment.dart';
import '../repository/map_repository.dart';

class GetAppoinmentOfPM {
  final MapRepository repo;

  GetAppoinmentOfPM(this.repo);
  Future<Either<Failure, List<Appoinment>>> getAppoinmentsPM(int id) async {
    return await repo.getAppoinmentsOfPM(id);
  }
}
