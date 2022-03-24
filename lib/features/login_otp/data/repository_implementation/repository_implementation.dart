import 'package:yalla_bus/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:yalla_bus/core/network/network_info.dart';
import 'package:yalla_bus/features/login_otp/data/firebase/send_code.dart';
import 'package:yalla_bus/features/login_otp/domain/repository/repository.dart';

class RepositoryImplementation extends Repository {
  final NetworkInfo network;
  final FirebaseAuthLogin login;
  RepositoryImplementation(this.network, this.login);
  @override
  Future<Either<Failure, String>> sendCodeToPhoneNumber(String number) async {
    if (await network.isConnected()) {
      final response = await login.send(number);
      response.fold((failure) {
        return VerificationFailure('Error, Try again');
      }, (success) {
        return success;
      });
    }
    // return Left(NetworkFailure('You need to connect to internet'));
    return const Right("35ddddrrrr");
  }
}
