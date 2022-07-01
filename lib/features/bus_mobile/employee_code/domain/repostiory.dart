import 'package:dartz/dartz.dart';
import 'package:yalla_bus/features/bus_mobile/employee_code/domain/bus.dart';
import 'package:yalla_bus/features/bus_mobile/employee_code/domain/remote_data_source.dart';

import '../../../../../core/states/state.dart';
import '../../../../core/exceptions/exception.dart';
import '../../../../core/network/network_info.dart';
import '../../../settings/data/model/settings_model_converters.dart';
import '../../../settings/domain/entity/ride_history_model.dart';

class EmployeeCodeRepository {
  final EmployeeApiClient client;
  final NetworkInfo info;
  EmployeeCodeRepository(this.client, this.info);

  Future<Either<Failure, Employee>> getEmployee(String code) async {
    if (await info.isConnected()) {
      try {
        final result = await client.getEmployee(code);
        return Right(EmployeeModel.fromJson(result));
      } on ServerException {
        return Left(Failure('Try Again in another time'));
      }
    } else {
      return Left(Failure("You don't have access to internet!"));
    }
  }

  Future<Either<Failure, int>> saveTxRide(int empId, int busId) async {
    if (await info.isConnected()) {
      try {
        final result = await client.saveTxRide(empId, busId);
        return Right(result);
      } on ServerException {
        return Left(Failure('Try Again in another time'));
      }
    } else {
      return Left(Failure("You don't have access to internet!"));
    }
  }
}
