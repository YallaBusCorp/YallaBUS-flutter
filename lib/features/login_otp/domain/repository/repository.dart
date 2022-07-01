

import 'package:dartz/dartz.dart';

import '../../../../core/states/state.dart';
import '../../../bus_mobile/employee_code/domain/bus.dart';

abstract class LoginRepository {
 Future<Either<Failure, BusI>> getBusUid(int number);
}
