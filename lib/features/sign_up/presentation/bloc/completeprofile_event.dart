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
  final String town;

  const SendTownValueEvent(this.value, this.town);
}

class SendUniValueEvent extends CompleteprofileEvent {
  final int value;
  final String university;
  const SendUniValueEvent(this.value, this.university);
}

class GetStudentIDEvent extends CompleteprofileEvent{
  final String uid;

  const GetStudentIDEvent(this.uid);
}
