import 'package:dartz/dartz.dart';
import '../../../../core/states/state.dart';
import '../enitity/appoinment.dart';
import '../repository/map_repository.dart';

class GetAppoinmentOfAM {
  final MapRepository repo;

  GetAppoinmentOfAM(this.repo);
  Future<Either<Failure, List<Appoinment>>> getAppoinmentsAM(int id) async {
    return await repo.getAppoinmentsOfAM(id);
  }
}
