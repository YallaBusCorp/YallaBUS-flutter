part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class SendCodeVerificationEvent extends LoginEvent {
  final String number;

  const SendCodeVerificationEvent(this.number);
}

class VerifyCodeVerificationEvent extends LoginEvent {
  final String otpCode;

  const VerifyCodeVerificationEvent(this.otpCode);
}

class CheckIfUserIsStudentOrDriverEvent extends LoginEvent {}
