import 'package:dartz/dartz.dart';
import 'package:yalla_bus/features/login_otp/domain/repository/repository.dart';

import '../../../../core/failure/failure.dart';

class SendCodeVerification {
  final Repository repository;

  SendCodeVerification(this.repository);
  // Future<Either<Failure, bool>> call(String number) async{
    // return await repository.sendCodeToPhoneNumber(number);
}
