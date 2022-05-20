

import 'package:dartz/dartz.dart';

import '../../../../core/states/state.dart';
import '../enitity/student.dart';
import '../repository/complete_profile_repository.dart';

class PostStudentInformation{
  final CompleteProfileRepository repo;

  PostStudentInformation(this.repo);
  Future<Either<Failure, int>> postStudentInfo(Student student) async {
    return await repo.postStudentInfo(student);
  }
}