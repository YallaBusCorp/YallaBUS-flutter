part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class WritePhoneNumber extends LoginEvent {
  final int number;

  const WritePhoneNumber(this.number);
}

class RemovePhoneNumber extends LoginEvent {}

class WritePinCode extends LoginEvent {
  final int number;

  const WritePinCode(this.number);
}

class RemovePinNumber extends LoginEvent {}

class SendCodeVerification extends LoginEvent {
  final String number;

  const SendCodeVerification(this.number);
}

class VerifyCodeVerification extends LoginEvent {
  final String otpCode;

  const VerifyCodeVerification(this.otpCode);
}
