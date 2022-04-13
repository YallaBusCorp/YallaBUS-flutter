part of 'completeprofile_bloc.dart';

abstract class CompleteprofileEvent extends Equatable {
  const CompleteprofileEvent();

  @override
  List<Object> get props => [];
}

class GetAllTownsEvent extends CompleteprofileEvent {}

class GetAllUniversitiesEvent extends CompleteprofileEvent {}

class SendStudentDataEvent extends CompleteprofileEvent {
  final String userName;

  const SendStudentDataEvent(this.userName);
}

class SendTownValueEvent extends CompleteprofileEvent {
  final int value;

  const SendTownValueEvent(this.value);
}

class SendUniValueEvent extends CompleteprofileEvent {
  final int value;

  const SendUniValueEvent(this.value);
}
