import '../../../../core/exceptions/exception.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/states/state.dart';
import '../data_sources/remote_data_source.dart';
import '../model/company_converters.dart';
import '../../domain/enitity/company.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repository/company_repository.dart';

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
