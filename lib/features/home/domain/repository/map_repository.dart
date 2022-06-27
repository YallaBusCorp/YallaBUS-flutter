import 'package:dartz/dartz.dart';
import '../../../../core/states/state.dart';
import '../../../settings/domain/entity/ride_history_model.dart';
import '../enitity/appoinment.dart';
import '../enitity/map_point.dart';
import '../enitity/ride.dart';

abstract class MapRepository {
  Future<Either<Failure, List<Appoinment>>> getAppoinmentsOfAM(int id);
  Future<Either<Failure, List<Appoinment>>> getAppoinmentsOfPM(int id);
  Future<Either<Failure, List<MapPoint>>> getMapPickUpPoints(int id);
  Future<Either<Failure, List<MapPoint>>> getMapDropOffPoints(int id);
  Future<Either<Failure, RideHis>> getCurrentRide(String uid);
  Future<Either<Failure, Success>> bookRide(Ride ride);
  Future<Either<Failure, bool>> cancelRide(int bookingID);
}
