part of 'employee_code_bloc.dart';

abstract class EmployeeCodeState extends Equatable {
  const EmployeeCodeState();
  
  @override
  List<Object> get props => [];
}

class EmployeeCodeInitial extends EmployeeCodeState {}

class Loading extends EmployeeCodeState {}


class ChangeIndexOfPin extends EmployeeCodeState {}

class Saved extends EmployeeCodeState{}
