import 'package:dartz/dartz.dart';
import '../../../../core/states/state.dart';
import '../repository/complete_profile_repository.dart';

import '../enitity/town.dart';

class GetAllTowns{
  final CompleteProfileRepository repo;

  GetAllTowns(this.repo);
  Future<Either<Failure, List<Town>>> getAllTowns(int companyId) async {
    return await repo.getRemoteTowns(companyId);
  }
}