import 'package:dartz/dartz.dart';

import '../../../../core/states/state.dart';
import '../enitity/appoinment.dart';
import '../enitity/ride.dart';
import '../repository/map_repository.dart';

class BookRide {
  final MapRepository repo;

  BookRide(this.repo);
  Future<Either<Failure,int>> bookRide(Ride ride) async {
    return await repo.bookRide(ride);
  }
}