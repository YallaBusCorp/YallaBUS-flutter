import 'package:dartz/dartz.dart';
import 'package:yalla_bus/features/choose_company/domain/enitity/company.dart';
import 'package:yalla_bus/features/choose_company/domain/repository/company_repository.dart';

import '../../../../core/failure/failure.dart';

class GetCompaniesInfo {
  final CompanyRepository repo;

  GetCompaniesInfo(this.repo);
  Future<Either<Failure, List<Company>>> getCompanies() async {
    return await repo.getRemoteCompanies();
  }
}
