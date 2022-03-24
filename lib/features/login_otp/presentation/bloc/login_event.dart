part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class WritePhoneNumberEvent extends LoginEvent {
  final int number;

  const WritePhoneNumberEvent(this.number);
}

class RemovePhoneNumberEvent extends LoginEvent {}

class WritePinCodeEvent extends LoginEvent {
  final int number;

  const WritePinCodeEvent(this.number);
}

class RemovePinNumberEvent extends LoginEvent {}

class SendCodeVerificationEvent extends LoginEvent {
  final String number;

  const SendCodeVerificationEvent(this.number);
}

class VerifyCodeVerificationEvent extends LoginEvent {
  final String otpCode;

  const VerifyCodeVerificationEvent(this.otpCode);
}
