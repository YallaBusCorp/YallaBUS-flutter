import 'package:dartz/dartz.dart';
import '../../../../core/states/state.dart';
import '../repository/complete_profile_repository.dart';



class GetStudentId {
  final CompleteProfileRepository repo;

  GetStudentId(this.repo);
  Future<Either<Failure, int>> getStudentId(String uid) async {
    return await repo.getStudentID(uid);
  }
}
