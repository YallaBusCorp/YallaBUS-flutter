import '../../../../core/exceptions/exception.dart';
import '../../../../core/network/network_info.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/states/state.dart';
import '../data_sources/remote_data_source.dart';
import '../model/complete_profile_converters.dart';
import '../../domain/enitity/student.dart';
import '../../domain/enitity/university.dart';
import '../../domain/enitity/town.dart';
import '../../domain/repository/complete_profile_repository.dart';

class ComplelteProfileRepositoryImplemenation
    extends CompleteProfileRepository {
  late List<dynamic> result;
  late int status;
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
  Future<Either<Failure, List<University>>> getRemoteUniversities(
      int companyId) async {
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

  @override
  Future<Either<Failure, int>> postStudentInfo(Student student) async {
    if (await info.isConnected()) {
      try {
        status = await client.postStudentInfo(student);
        if (status == 200) {
          return Right(status);
        } else {
          return Left(Failure("Try Again in another time"));
        }
      } on ServerException {
        return Left(Failure('Server Failure : Try Again in another time'));
      }
    } else {
      return Left(Failure("You don't have access to internet!"));
    }
  }
  
}
