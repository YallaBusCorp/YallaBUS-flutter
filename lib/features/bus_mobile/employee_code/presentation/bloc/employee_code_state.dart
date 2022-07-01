part of 'employee_code_bloc.dart';

abstract class EmployeeCodeState extends Equatable {
  const EmployeeCodeState();

  @override
  List<Object> get props => [];
}

class EmployeeCodeInitial extends EmployeeCodeState {}

class LoadingCode extends EmployeeCodeState {}

class ChangeIndexOfPin extends EmployeeCodeState {}

class Saved extends EmployeeCodeState {}

class AuthFailed extends EmployeeCodeState {
  final String message;

  const AuthFailed(this.message);
}

class AuthSuccess extends EmployeeCodeState {}

class GetEmployeeSuccess extends EmployeeCodeState {}

