import 'package:dartz/dartz.dart';
import '../enitity/ride.dart';
import '../repository/map_repository.dart';
import '../../../../core/states/state.dart';
import '../../../sign_up/domain/repository/complete_profile_repository.dart';

class GetStudentId {
  final MapRepository repo;

  GetStudentId(this.repo);
  Future<Either<Failure, StudentID>> getStudentId(String uid) async {
    return await repo.getStudentID(uid);
  }
}
