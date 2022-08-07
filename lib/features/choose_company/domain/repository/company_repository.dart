import 'package:dartz/dartz.dart';

import '../../../../core/states/state.dart';
import '../enitity/company.dart';

abstract class CompanyRepository {
  Future<Either<Failure, List<Company>>> getRemoteCompanies();
}
