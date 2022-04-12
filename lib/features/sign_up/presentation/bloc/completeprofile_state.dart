part of 'completeprofile_bloc.dart';

abstract class CompleteprofileState extends Equatable {
  const CompleteprofileState();

  @override
  List<Object> get props => [];
}

class CompleteprofileInitial extends CompleteprofileState {}

class FetchUniSuccess extends CompleteprofileState {
  final List<University> universities;

  const FetchUniSuccess(this.universities);
  @override
  List<Object> get props => [universities];
}

class FetchTownsSuccess extends CompleteprofileState {
  final List<Town> towns;

  const FetchTownsSuccess(this.towns);
  @override
  List<Object> get props => [towns];
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
