part of 'keyboard_bloc.dart';

abstract class KeyboardState extends Equatable {
  const KeyboardState();
  
  @override
  List<Object> get props => [];
}

class KeyboardInitial extends KeyboardState {}

class Loading extends KeyboardState{}

class ChangeIndexOfNumber extends KeyboardState{}
 
class ChangeIndexOfPin extends KeyboardState{}

