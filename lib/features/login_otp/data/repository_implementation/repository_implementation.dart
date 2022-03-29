import 'package:yalla_bus/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:yalla_bus/core/network/network_info.dart';
import 'package:yalla_bus/features/login_otp/domain/repository/repository.dart';

class RepositoryImplementation extends Repository {
  // final NetworkInfo network;
  // final FirebaseAuthLogin login;
  // RepositoryImplementation(this.network, this.login);
  // @override
  // Future<Either<Failure, bool>> sendCodeToPhoneNumber(String number) async {
  //   if (await network.isConnected()) {
  //     final response = await login.sendOtpCodeToMobile(number);
  //     if (response == VerificationFailure()) {
  //       return Left(
  //           VerificationFailure(message: 'Oops!, Try again in another time'));
  //     } else {
  //       return const Right(true);
  //     }
  //   } else {
  //     return Left(NetworkFailure(message: 'You need to connect to internet'));
  //   }
}
