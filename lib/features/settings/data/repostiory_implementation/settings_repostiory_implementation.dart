import 'package:dartz/dartz.dart';

import '../../../../core/network/network_info.dart';
import '../../../../core/states/state.dart';
import '../../../choose_company/data/model/company_converters.dart';
import '../../../choose_company/domain/enitity/company.dart';
import '../../../sign_up/domain/enitity/student.dart';
import '../../domain/entity/ride_history_model.dart';
import '../../domain/repostiory/settings_repostiory.dart';
import '../data_sources/settings_remote_data_source.dart';
import '../model/settings_model_converters.dart';

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

  @override
  Future<Either<List<RideHis>, Failure>> getNonScannedRides(int id) async {
    if (await network.isConnected()) {
      try {
        List<dynamic> list = await client.getNonScannedRides(id);
        return Left(list.map((e) => RideHisModel.fromJson(e)).toList());
      } on ServerFailure {
        return Right(Failure("Server Failure"));
      }
    } else {
      return Right(Failure("You don't have internet access!"));
    }
  }

  @override
  Future<Either<List<RideHis>, Failure>> getScannedRides(int id) async {
    if (await network.isConnected()) {
      try {
        List<dynamic> list = await client.getScannedRides(id);
        return Left(list.map((e) => RideHisModel.fromJson(e)).toList());
      } on ServerFailure {
        return Right(Failure("Server Failure"));
      }
    } else {
      return Right(Failure("You don't have internet access!"));
    }
  }
}
