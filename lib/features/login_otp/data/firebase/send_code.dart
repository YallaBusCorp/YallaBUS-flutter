import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/failure/failure.dart';

class FirebaseAuthLogin {
  Future<Either<Failure, String>> send(String number) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    String id = "";
    await _auth.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (AuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException authException) {},
      codeSent: (String verificationId, int? resendToken) async {
        id = verificationId;
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    return id.isEmpty? Left(VerificationFailure('Error, Try again')) : Right(id);
  }
}
