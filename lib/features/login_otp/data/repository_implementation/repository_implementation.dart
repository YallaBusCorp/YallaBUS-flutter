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
        return Left(
            VerificationFailure(message: 'Oops! Try again in another time!'));
      }, (success) {
        return Right(success);
      });
    }

    return Left(NetworkFailure(message: 'You need to connect to internet'));
  }
}
