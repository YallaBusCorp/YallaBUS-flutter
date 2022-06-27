import 'package:dartz/dartz.dart';

import '../../../../core/states/state.dart';
import '../enitity/appoinment.dart';
import '../enitity/ride.dart';
import '../repository/map_repository.dart';

class CancelRide {
  final MapRepository repo;

  CancelRide(this.repo);
  Future<Either<Failure,bool>> cancelRide(int bookingID) async {
    return await repo.cancelRide(bookingID);
  }
}