import 'package:dartz/dartz.dart';
import 'package:yalla_bus/features/sign_up/domain/repository/complete_profile_repository.dart';

import '../../../../core/failure/failure.dart';
import '../enitity/town.dart';

class GetAllTowns{
  final CompleteProfileRepository repo;

  GetAllTowns(this.repo);
  Future<Either<Failure, List<Town>>> getAllTowns(int companyId) async {
    return await repo.getRemoteTowns(companyId);
  }
}