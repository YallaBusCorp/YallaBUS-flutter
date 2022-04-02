part of 'keyboard_bloc.dart';

abstract class KeyboardEvent extends Equatable {
  const KeyboardEvent();

  @override
  List<Object> get props => [];
}

class WritePhoneNumberEvent extends KeyboardEvent {
  final int number;

  const WritePhoneNumberEvent(this.number);
}

class RemovePhoneNumberEvent extends KeyboardEvent {}

class WritePinCodeEvent extends KeyboardEvent {
  final int number;

  const WritePinCodeEvent(this.number);
}

class RemovePinNumberEvent extends KeyboardEvent {}
