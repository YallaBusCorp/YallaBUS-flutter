import 'package:dartz/dartz.dart';
import 'package:yalla_bus/core/failure/failure.dart';
import 'package:yalla_bus/features/choose_company/domain/enitity/company.dart';
import 'package:yalla_bus/features/sign_up/domain/enitity/student.dart';
import 'package:yalla_bus/features/sign_up/domain/enitity/university.dart';

import '../enitity/town.dart';

abstract class CompleteProfileRepository {
  Future<Either<Failure, List<University>>> getRemoteUniversities(
      int companyId);
  Future<Either<Failure, List<Town>>> getRemoteTowns(int companyId);
  Future<Either<Failure, int>> postStudentInfo(Student student);
}
