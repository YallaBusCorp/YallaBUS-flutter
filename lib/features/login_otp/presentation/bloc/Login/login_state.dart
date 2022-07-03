part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class Loading extends LoginState {}

class SendingData extends LoginState {}

class SuccessVerfication extends LoginState {
  final String token;
  final String number;
  const SuccessVerfication(this.token, this.number);
}

class Success extends LoginState {}

class Error extends LoginState {
  final String message;

  const Error(this.message);
}

class ThisIsStudentAccount extends LoginState {}

class ThisIsDriverAccount extends LoginState {}

class PerfsRefersh extends LoginState {}

class ThisIsNewStudentAccount extends LoginState {}
