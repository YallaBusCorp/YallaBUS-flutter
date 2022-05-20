import 'package:dartz/dartz.dart';
import '../repostiory/settings_repostiory.dart';

import '../../../../core/failure/failure.dart';
import '../../../choose_company/domain/enitity/company.dart';

class GetCompanyInfo {
  final SettingsRepostiory repo;

  GetCompanyInfo(this.repo);

  Future<Either<Company, Failure>> getCompanyInfo(int id) {
    return repo.getCompanyInfo(id);
  }
}
