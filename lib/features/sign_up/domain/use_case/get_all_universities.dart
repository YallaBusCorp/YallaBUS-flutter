import 'package:dartz/dartz.dart';
import 'package:yalla_bus/features/choose_company/domain/repository/company_repository.dart';
import 'package:yalla_bus/features/sign_up/domain/enitity/university.dart';
import 'package:yalla_bus/features/sign_up/domain/repository/complete_profile_repository.dart';

import '../../../../core/failure/failure.dart';

class GetAllUniversities {
  final CompleteProfileRepository repo;

  GetAllUniversities(this.repo);
  Future<Either<Failure, List<University>>> getAllUniversities(int companyId) async {
    return await repo.getRemoteUniversities(companyId);
  }
}
