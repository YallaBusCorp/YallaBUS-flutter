import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:dartz/dartz.dart';
import 'package:yalla_bus/features/login_otp/domain/use%20case/send_code_verification.dart';
import '../../../../../core/injection/di.dart';
import '../../../../../core/network/network_info.dart';
import '../../../../../core/resources/routes_manager.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final NetworkInfo network = di<NetworkInfo>();
  late String verificationId;
  late UserCredential user;

  void onChange(Change<LoginState> change) {
    super.onChange(change);
    print(change);
  }

  LoginBloc() : super(LoginInitial()) {
    on<SendCodeVerificationEvent>((event, emit) async {
      emit(SendingData());
      FirebaseAuth _auth = FirebaseAuth.instance;
      if (await network.isConnected()) {
        await _auth.verifyPhoneNumber(
            phoneNumber: event.number,
            verificationCompleted: verificationCompleted,
            verificationFailed: verificationFailed,
            codeSent: codeSent,
            timeout: const Duration(seconds: 60),
            codeAutoRetrievalTimeout: (String verificationId) {});
      } else {
        emit(const Error('You are not connected to internet'));
      }
    });

    on<VerifyCodeVerificationEvent>((event, emit) async {
      await submitOtp(event.otpCode);
    });
  }

  void verificationCompleted(AuthCredential credential) {}
  void verificationFailed(FirebaseAuthException authException) {
    emit(Error('${authException.message}'));
  }

  void codeSent(String verificationId, int? resendToken) {
    this.verificationId = verificationId;
    emit(Success(true));
  }

  Future<void> submitOtp(String otpCode) async {
    emit(SendingData());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpCode);
    try {
      user = await FirebaseAuth.instance.signInWithCredential(credential);
      emit(const Success(true));
    } on FirebaseAuthException {
      emit(const Error('Wrong Verification!'));
    }
  }
}
