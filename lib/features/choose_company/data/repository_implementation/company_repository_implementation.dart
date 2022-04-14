import 'package:yalla_bus/core/exceptions/exception.dart';
import 'package:yalla_bus/core/network/network_info.dart';
import 'package:yalla_bus/features/choose_company/data/data_sources/remote_data_source.dart';
import 'package:yalla_bus/features/choose_company/data/model/company_converters.dart';
import 'package:yalla_bus/features/choose_company/domain/enitity/company.dart';
import 'package:yalla_bus/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:yalla_bus/features/choose_company/domain/repository/company_repository.dart';

class CompanyRepositoryImplementation extends CompanyRepository {
  late List<dynamic> result;
  late List<Company> companies;
  final CompaniesApiClient client;
  final NetworkInfo info;

  CompanyRepositoryImplementation(this.client, this.info);
  @override
  Future<Either<Failure, List<Company>>> getRemoteCompanies() async {
    if (await info.isConnected()) {
      try {
        result = await client.getCompaniesInformation();
        companies = result.map((e) => CompanyModel.fromJson(e)).toList();
        return Right(companies);
      } on ServerException {
        return Left(Failure('Server Failure : Try Again in another time'));
      }
    } else {
      // Edit This
      return Left(Failure("You don't have access to internet!"));
    }
  }
}
