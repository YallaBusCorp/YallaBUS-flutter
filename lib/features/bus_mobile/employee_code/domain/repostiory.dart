import 'package:dartz/dartz.dart';
import 'package:yalla_bus/features/bus_mobile/employee_code/domain/bus.dart';
import 'package:yalla_bus/features/bus_mobile/employee_code/domain/remote_data_source.dart';

import '../../../../../core/states/state.dart';
import '../../../../core/exceptions/exception.dart';
import '../../../../core/network/network_info.dart';
import '../../../settings/domain/entity/ride_history_model.dart';

class EmployeeCodeRepository {
  final EmployeeApiClient client;
  final NetworkInfo info;
  EmployeeCodeRepository(this.client, this.info);
  Future<Either<Failure, BusI>> getBusUid(int number) async {
    if (await info.isConnected()) {
      try {
        final result = await client.getBusUid(number);     
        return Right(BusI.fromJson(result));
      } on ServerException {
        return Left(Failure('Try Again in another time'));
      }
    } else {
      return Left(Failure("You don't have access to internet!"));
    }
  }
}
