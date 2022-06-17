import 'package:dartz/dartz.dart';

import '../../../../core/states/state.dart';
import '../../../choose_company/domain/enitity/company.dart';
import '../../../sign_up/domain/enitity/student.dart';

abstract class SettingsRepostiory {
  Future<Either<Company, Failure>> getCompanyInfo(int id);
  Future<Either<Success, Failure>> update(Student student);
}
