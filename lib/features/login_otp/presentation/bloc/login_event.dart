part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class WritePhoneNumber extends LoginEvent{
  final int number;

  const WritePhoneNumber(this.number);
}

class RemovePhoneNumber extends LoginEvent{
}
