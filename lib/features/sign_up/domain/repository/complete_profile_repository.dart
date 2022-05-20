import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../enitity/student.dart';
import '../enitity/university.dart';

import '../enitity/town.dart';

abstract class CompleteProfileRepository {
  Future<Either<Failure, List<University>>> getRemoteUniversities(
      int companyId);
  Future<Either<Failure, List<Town>>> getRemoteTowns(int companyId);
  Future<Either<Failure, int>> postStudentInfo(Student student);
}
