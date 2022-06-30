import 'package:yalla_bus/core/states/state.dart';
import 'package:dartz/dartz.dart';
import 'package:yalla_bus/features/bus_mobile/qr_scanner/data/remote_data_source.dart';
import 'package:yalla_bus/features/bus_mobile/rides/data/json_converters.dart';
import 'package:yalla_bus/features/bus_mobile/rides/data/remote_data_source.dart';
import 'package:yalla_bus/features/bus_mobile/rides/domain/entity/all_rides.dart';

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
