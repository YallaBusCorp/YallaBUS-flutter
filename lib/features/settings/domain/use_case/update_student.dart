import 'package:dartz/dartz.dart';

import '../../../../core/states/state.dart';
import '../../../sign_up/domain/enitity/student.dart';
import '../repostiory/settings_repostiory.dart';

class UpdateStudentInfo {
  final SettingsRepostiory repo;

  UpdateStudentInfo(this.repo);

  Future<Either<Success, Failure>> update(Student student) {
    return repo.update(student);
  }
}
