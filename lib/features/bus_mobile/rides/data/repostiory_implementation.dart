import '../../../../core/states/state.dart';
import 'package:dartz/dartz.dart';
import '../../qr_scanner/data/remote_data_source.dart';
import 'json_converters.dart';
import 'remote_data_source.dart';
import '../domain/entity/all_rides.dart';

import '../../../../core/exceptions/exception.dart';
import '../../../../core/network/network_info.dart';

class BusRideRepostiory {
  final BusRideApiClient client;
  final NetworkInfo info;

  BusRideRepostiory(this.client, this.info);
  @override
  Future<Either<Failure, List<Booking>>> getCurrentRideByBusUid(
      String busUid) async {
    if (await info.isConnected()) {
      try {
        final result = await client.getCurrentRideByBusUid(busUid);
        return Right(result.map((e) => BookingModel.fromJson(e)).toList());
      } on ServerException {
        return Left(Failure('Try Again in another time'));
      }
    } else {
      return Left(Failure("You don't have access to internet!"));
    }
  }
}
