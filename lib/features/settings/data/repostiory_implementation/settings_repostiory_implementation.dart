import 'package:yalla_bus/features/sign_up/data/model/complete_profile_converters.dart';
import 'package:yalla_bus/features/sign_up/domain/enitity/student.dart';

import '../../../../core/network/network_info.dart';
import '../../../../core/states/state.dart';
import '../../../choose_company/data/model/company_converters.dart';
import '../../../choose_company/domain/enitity/company.dart';
import 'package:dartz/dartz.dart';
import '../data_sources/settings_remote_data_source.dart';
import '../../domain/repostiory/settings_repostiory.dart';

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

  @override
  Future<Either<Success, Failure>> update(Student student) async {
    if (await network.isConnected()) {
      try {
        await client.update(student);
        return Left(Success());
      } on ServerFailure {
        return Right(Failure("Server Failure"));
      }
    } else {
      return Right(Failure("You don't have internet access!"));
    }
  }
}
