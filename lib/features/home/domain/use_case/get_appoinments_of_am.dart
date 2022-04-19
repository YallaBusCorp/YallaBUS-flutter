import 'package:dartz/dartz.dart';
import 'package:yalla_bus/features/choose_company/domain/enitity/company.dart';
import 'package:yalla_bus/features/choose_company/domain/repository/company_repository.dart';
import 'package:yalla_bus/features/home/domain/enitity/appoinment.dart';
import 'package:yalla_bus/features/home/domain/repository/map_repository.dart';

import '../../../../core/failure/failure.dart';

class GetAppoinmentOfAM {
  final MapRepository repo;

  GetAppoinmentOfAM(this.repo);
  Future<Either<Failure, List<Appoinment>>> getAppoinmentsAM(int id) async {
    return await repo.getAppoinmentsOfAM(id);
  }
}
