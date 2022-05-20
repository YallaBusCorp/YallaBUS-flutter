import 'package:dartz/dartz.dart';
import 'package:yalla_bus/features/home/domain/enitity/ride.dart';

import '../../../../core/states/state.dart';
import '../enitity/appoinment.dart';
import '../repository/map_repository.dart';

class GetStudentId {
  final MapRepository repo;

  GetStudentId(this.repo);
  Future<Either<Failure, int>> getStudentId(String uid) async {
    return await repo.getStudentId(uid);
  }
}
