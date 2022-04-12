part of 'completeprofile_bloc.dart';

abstract class CompleteprofileEvent extends Equatable {
  const CompleteprofileEvent();

  @override
  List<Object> get props => [];
}

class GetAllTownsEvent extends CompleteprofileEvent {}

class GetAllUniversitiesEvent extends CompleteprofileEvent {}
