import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';

abstract class Repository{
  Future<Either<Failure,String>> sendCodeToPhoneNumber(String number);
}