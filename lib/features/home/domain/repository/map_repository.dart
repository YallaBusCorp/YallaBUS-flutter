import 'package:dartz/dartz.dart';
import 'package:yalla_bus/core/failure/failure.dart';
import 'package:yalla_bus/features/choose_company/domain/enitity/company.dart';
import 'package:yalla_bus/features/home/domain/enitity/appoinment.dart';

abstract class MapRepository {
  Future<Either<Failure, List<Appoinment>>> getAppoinmentsOfAM(int id);
  Future<Either<Failure, List<Appoinment>>> getAppoinmentsOfPM(int id);
}
