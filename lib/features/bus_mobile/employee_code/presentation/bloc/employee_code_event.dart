part of 'employee_code_bloc.dart';

abstract class EmployeeCodeEvent extends Equatable {
  const EmployeeCodeEvent();

  @override
  List<Object> get props => [];
}

class WritePinCodeEvent extends EmployeeCodeEvent {
  final int number;

  const WritePinCodeEvent(this.number);
}

class RemovePinNumberEvent extends EmployeeCodeEvent {}

class SaveEmployeeCodeEvent extends EmployeeCodeEvent {
  final String code;

  const SaveEmployeeCodeEvent(this.code);
}
