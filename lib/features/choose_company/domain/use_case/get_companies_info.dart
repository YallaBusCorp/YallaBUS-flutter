import 'package:dartz/dartz.dart';
import '../../../../core/states/state.dart';
import '../enitity/company.dart';
import '../repository/company_repository.dart';


class GetCompaniesInfo {
  final CompanyRepository repo;

  GetCompaniesInfo(this.repo);
  Future<Either<Failure, List<Company>>> getCompanies() async {
    return await repo.getRemoteCompanies();
  }
}
