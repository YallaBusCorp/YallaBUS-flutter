import 'package:dartz/dartz.dart';

import '../../../../../core/states/state.dart';
import '../../../../core/exceptions/exception.dart';
import '../../../../core/network/network_info.dart';
import 'remote_data_source.dart';

class BusMapRepository {
  final BusMapApiClient client;
  final NetworkInfo info;
  BusMapRepository(this.client, this.info);
  Future<Either<Failure, bool>> finishRide(int id) async {
    if (await info.isConnected()) {
      try {
        final result = await client.finishRide(id);
        return Right(result);
      } on ServerException {
        return Left(Failure('Try Again in another time'));
      }
    } else {
      return Left(Failure("You don't have access to internet!"));
    }
  }
}
