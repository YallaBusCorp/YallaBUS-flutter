import 'package:dartz/dartz.dart';
import '../../../../core/states/state.dart';
import '../enitity/university.dart';
import '../repository/complete_profile_repository.dart';


class GetAllUniversities {
  final CompleteProfileRepository repo;

  GetAllUniversities(this.repo);
  Future<Either<Failure, List<University>>> getAllUniversities(int companyId) async {
    return await repo.getRemoteUniversities(companyId);
  }
}
