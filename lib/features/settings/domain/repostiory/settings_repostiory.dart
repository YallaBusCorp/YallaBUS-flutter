import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../../../choose_company/domain/enitity/company.dart';

abstract class SettingsRepostiory {
  Future<Either<Company, Failure>> getCompanyInfo(int id);
}
