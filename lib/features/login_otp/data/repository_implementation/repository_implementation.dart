import '../../../../core/states/state.dart';

import 'package:dartz/dartz.dart';
import '../remote_data_source/login_remote_data_source.dart';

import '../../../../core/exceptions/exception.dart';
import '../../../../core/network/network_info.dart';
import '../../../bus_mobile/employee_code/domain/bus.dart';
import '../../domain/repository/repository.dart';

class LoginRepositoryImplementation extends LoginRepository {
  final LoginApiClient client;
  final NetworkInfo info;
  LoginRepositoryImplementation(this.client, this.info);
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
