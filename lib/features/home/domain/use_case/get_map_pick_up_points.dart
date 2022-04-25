import 'package:dartz/dartz.dart';
import 'package:yalla_bus/features/choose_company/domain/enitity/company.dart';
import 'package:yalla_bus/features/choose_company/domain/repository/company_repository.dart';
import 'package:yalla_bus/features/home/domain/enitity/appoinment.dart';
import 'package:yalla_bus/features/home/domain/enitity/map_point.dart';
import 'package:yalla_bus/features/home/domain/repository/map_repository.dart';

import '../../../../core/failure/failure.dart';

class GetMapPickUpPoints {
  final MapRepository repo;

  GetMapPickUpPoints(this.repo);
  Future<Either<Failure, List<MapPoint>>> getMapPickUpPoints(int id) async {
    return await repo.getMapPickUpPoints(id);
  }
}
