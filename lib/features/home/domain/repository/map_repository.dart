import 'package:dartz/dartz.dart';
import '../../../../core/states/state.dart';
import '../enitity/appoinment.dart';
import '../enitity/map_point.dart';

abstract class MapRepository {
  Future<Either<Failure, List<Appoinment>>> getAppoinmentsOfAM(int id);
  Future<Either<Failure, List<Appoinment>>> getAppoinmentsOfPM(int id);
  Future<Either<Failure, List<MapPoint>>> getMapPickUpPoints(int id);
  Future<Either<Failure, List<MapPoint>>> getMapDropOffPoints(int id);
  Future<Either<Failure, Success>> bookRide(int id);

}
