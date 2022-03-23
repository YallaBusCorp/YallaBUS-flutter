import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:dartz/dartz.dart';
import '../../../../core/resources/routes_manager.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  List<int> phoneNumber = List.generate(9, (index) => 0);
  List<String> pins = List.generate(6, (index) => '');

  late String verificationId;

  int indexOfPhoneNumber = 0;
  int indexOfPinNumber = 0;
  LoginBloc() : super(LoginInitial()) {
    on<WritePhoneNumber>((event, emit) {
      // TODO: implement event handler
      emit(Loading());
      phoneNumber[indexOfPhoneNumber] = event.number;
      if (indexOfPhoneNumber < phoneNumber.length) {
        indexOfPhoneNumber++;
      }
      emit(ChangeIndexOfNumber());
    });

    on<RemovePhoneNumber>((event, emit) {
      // TODO: implement event handler
      emit(Loading());
      if (indexOfPhoneNumber >= 1) {
        indexOfPhoneNumber--;
        phoneNumber[indexOfPhoneNumber] = 0;
      }
      emit(ChangeIndexOfNumber());
    });

    on<WritePinCode>((event, emit) {
      // TODO: implement event handler
      emit(Loading());
      pins[indexOfPinNumber] = event.number.toString();
      if (indexOfPinNumber < pins.length) {
        indexOfPinNumber++;
      }
      emit(ChangeIndexOfNumber());
    });

    on<RemovePinNumber>((event, emit) {
      // TODO: implement event handler
      emit(Loading());
      if (indexOfPinNumber >= 1) {
        indexOfPinNumber--;
        pins[indexOfPinNumber] = '';
      }
      emit(ChangeIndexOfNumber());
    });

    on<SendCodeVerification>((event, emit)async {
      // TODO: implement event handler
      emit(SendingData());
      FirebaseAuth _auth = FirebaseAuth.instance;
      await _auth.verifyPhoneNumber(
        phoneNumber: event.number,
        verificationCompleted: (AuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException authException){
          print('$authException');
          // emit(Error()) ;
        },
        codeSent: (String verificationId, int? resendToken) async {
          this.verificationId = verificationId;
          emit(Success());
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      // emit(ChangeIndexOfNumber());
    });

    on<VerifyCodeVerification>((event, emit) async {
      emit(SendingData());
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: event.otpCode);
      try{
        await FirebaseAuth.instance.signInWithCredential(credential);
        emit(Success());
      }catch (e){
        emit(Error());
      }
  
    });
  }
}
