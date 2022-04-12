import 'package:yalla_bus/core/exceptions/exception.dart';
import 'package:yalla_bus/core/network/network_info.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';
import 'package:yalla_bus/features/choose_company/data/data_sources/remote_data_source.dart';
import 'package:yalla_bus/features/choose_company/data/model/company_converters.dart';
import 'package:yalla_bus/features/choose_company/domain/enitity/company.dart';
import 'package:yalla_bus/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:yalla_bus/features/choose_company/domain/repository/company_repository.dart';
import 'package:yalla_bus/features/sign_up/data/data_sources/remote_data_source.dart';
import 'package:yalla_bus/features/sign_up/data/model/signUp_converters.dart';
import 'package:yalla_bus/features/sign_up/domain/enitity/university.dart';
import 'package:yalla_bus/features/sign_up/domain/enitity/town.dart';
import 'package:yalla_bus/features/sign_up/domain/repository/complete_profile_repository.dart';

class ComplelteProfileRepositoryImplemenation extends CompleteProfileRepository {
  late List<dynamic> result;
  late List<University> universities;
  late List<Town> towns;
  final CompleteProfileApiClient client;
  final NetworkInfo info;

  ComplelteProfileRepositoryImplemenation(this.client, this.info);

  @override
  Future<Either<Failure, List<Town>>> getRemoteTowns(int companyId) async {
    if (await info.isConnected()) {
      try {
        result = await client.getTowns(companyId);
        towns = result.map((e) => TownModel.fromJson(e)).toList();
        return Right(towns);
      } on ServerException {
        return Left(Failure('Server Failure : Try Again in another time'));
      }
    } else {
      // Edit This
      return Left(Failure("You don't have access to internet!"));
    }
  }

  @override
  Future<Either<Failure, List<University>>> getRemoteUniversities(int companyId) async {
    if (await info.isConnected()) {
      try {
        result = await client.getUniversities(companyId);
        universities = result.map((e) => UniversityModel.fromJson(e)).toList();
        return Right(universities);
      } on ServerException {
        return Left(Failure('Server Failure : Try Again in another time'));
      }
    } else {
      // Edit This
      return Left(Failure("You don't have access to internet!"));
    }
  }
}
