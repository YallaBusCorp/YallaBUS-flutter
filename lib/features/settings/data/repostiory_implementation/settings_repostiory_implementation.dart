import 'package:yalla_bus/core/network/network_info.dart';
import 'package:yalla_bus/features/choose_company/data/model/company_converters.dart';
import 'package:yalla_bus/features/choose_company/domain/enitity/company.dart';
import 'package:yalla_bus/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:yalla_bus/features/settings/data/data_sources/settings_remote_data_source.dart';
import 'package:yalla_bus/features/settings/domain/repostiory/settings_repostiory.dart';

class SettingsRepostioryImplementation extends SettingsRepostiory {
  late Map<String, dynamic> result;
  late Company company;
  final SettingsApiClient client;
  final NetworkInfo network;

  SettingsRepostioryImplementation(this.client, this.network);
  @override
  Future<Either<Company, Failure>> getCompanyInfo(int id) async {
    if (await network.isConnected()) {
      try {
        result = await client.getCompanyInfo(id);
        company = CompanyModel.fromJson(result);
        return Left(company);
      } on ServerFailure {
        return Right(Failure("Server Failure"));
      }
    } else {
      return Right(Failure("You don't have internet access!"));
    }
  }
}
