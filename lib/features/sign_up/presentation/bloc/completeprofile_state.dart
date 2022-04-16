part of 'completeprofile_bloc.dart';

abstract class CompleteprofileState extends Equatable {
  const CompleteprofileState();

  @override
  List<Object> get props => [];
}

class CompleteprofileInitial extends CompleteprofileState {}

class FetchUniSuccess extends CompleteprofileState {
  final List<String> universities;
  final List<int> universitiesId;

  const FetchUniSuccess(this.universities, this.universitiesId);
  @override
  List<Object> get props => [universities, universitiesId];
}

class FetchTownsSuccess extends CompleteprofileState {
  final List<String> towns;
  final List<int> townsId;

  const FetchTownsSuccess(this.towns, this.townsId);
  @override
  List<Object> get props => [towns, townsId];
}

class FetchUniError extends CompleteprofileState {
  final String message;

  const FetchUniError(this.message);

  @override
  List<Object> get props => [message];
}

class FetchTownsError extends CompleteprofileState {
  final String message;

  const FetchTownsError(this.message);

  @override
  List<Object> get props => [message];
}

class PostStudentDataSuccess extends CompleteprofileState {}

class PostStudentDataError extends CompleteprofileState {
  final String message;

  const PostStudentDataError(this.message);
}

class ChangeTownValue extends CompleteprofileState {}

class ChangeUniValue extends CompleteprofileState {}

class LoadingSendData extends CompleteprofileState {}
