import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:dartz/dartz.dart';
import 'package:yalla_bus/features/login_otp/domain/use%20case/send_code_verification.dart';
import '../../../../core/injection/di.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/resources/routes_manager.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  List<int> phoneNumber = List.generate(9, (index) => 0);
  List<String> pins = List.generate(6, (index) => '');
  String number = "+201";
  String pinCode = "";
  final NetworkInfo network = di<NetworkInfo>();
  late String verificationId;
  late UserCredential user;
  int indexOfPhoneNumber = 0;
  int indexOfPinNumber = 0;

  void onChange(Change<LoginState> change) {
    super.onChange(change);
    print(change);
  }

  LoginBloc() : super(LoginInitial()) {
    on<WritePhoneNumberEvent>((event, emit) {
      emit(Loading());
      phoneNumber[indexOfPhoneNumber] = event.number;
      number += event.number.toString();
      if (indexOfPhoneNumber < phoneNumber.length) {
        indexOfPhoneNumber++;
      }
      emit(ChangeIndexOfNumber());
    });

    on<RemovePhoneNumberEvent>((event, emit) {
      emit(Loading());
      if (indexOfPhoneNumber >= 1) {
        number = number.substring(0, number.length - 1);
        indexOfPhoneNumber--;
        phoneNumber[indexOfPhoneNumber] = 0;
      }
      emit(ChangeIndexOfNumber());
    });

    on<WritePinCodeEvent>((event, emit) {
      emit(Loading());
      pins[indexOfPinNumber] = event.number.toString();
      pinCode += event.number.toString();
      if (indexOfPinNumber < pins.length) {
        indexOfPinNumber++;
      }
      emit(ChangeIndexOfNumber());
    });

    on<RemovePinNumberEvent>((event, emit) {
      emit(Loading());
      if (indexOfPinNumber >= 1) {
        pinCode = pinCode.substring(0, pinCode.length - 1);
        indexOfPinNumber--;
        pins[indexOfPinNumber] = '';
      }
      emit(ChangeIndexOfNumber());
    });

    on<SendCodeVerificationEvent>((event, emit) async {
      emit(SendingData());
      FirebaseAuth _auth = FirebaseAuth.instance;
      if (await network.isConnected()) {
        await _auth.verifyPhoneNumber(
            phoneNumber: number,
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
