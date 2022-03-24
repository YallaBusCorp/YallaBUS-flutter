import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:dartz/dartz.dart';
import 'package:yalla_bus/features/login_otp/domain/use%20case/send_code_verification.dart';
import '../../../../core/injection/di.dart';
import '../../../../core/resources/routes_manager.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  List<int> phoneNumber = List.generate(9, (index) => 0);
  List<String> pins = List.generate(6, (index) => '');
  String number = "+201";
  String pinCode = "";
  final SendCodeVerification _sendCodeVerification = di<SendCodeVerification>();
  late String verificationId;

  int indexOfPhoneNumber = 0;
  int indexOfPinNumber = 0;
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
      pinCode = event.number.toString();
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
      final verificationSendResponse =
          await _sendCodeVerification.call(event.number);
      verificationSendResponse.fold((failure) {
        emit(Error(failure.message));
      }, (success) {
        verificationId = success.toString();
        emit(Success());
      });
    });

    on<VerifyCodeVerificationEvent>((event, emit) async {
      emit(SendingData());
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: event.otpCode);
      try {
        await FirebaseAuth.instance.signInWithCredential(credential);
        emit(Success());
      } catch (e) {
        emit(const Error('Error'));
      }
    });
  }
}
