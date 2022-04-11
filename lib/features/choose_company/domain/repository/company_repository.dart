import 'package:dartz/dartz.dart';
import 'package:yalla_bus/core/failure/failure.dart';
import 'package:yalla_bus/features/choose_company/domain/enitity/company.dart';

abstract class CompanyRepository {
  Future<Either<Failure, List<Company>>> getRemoteCompanies();
}
