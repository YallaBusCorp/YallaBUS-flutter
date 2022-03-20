part of 'company_selection_bloc.dart';

abstract class CompanySelectionState extends Equatable {
  const CompanySelectionState();
  
  @override
  List<Object> get props => [];
}

class CompanySelectionInitial extends CompanySelectionState {}

class Loading extends CompanySelectionState{}

class ChangeSelection extends CompanySelectionState{

}


