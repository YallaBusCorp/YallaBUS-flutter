part of 'company_selection_bloc.dart';

abstract class CompanySelectionEvent extends Equatable {
  const CompanySelectionEvent();

  @override
  List<Object> get props => [];
}

class SelectCompanyUIEvent extends CompanySelectionEvent {
  final int indexOfCompany;
  const SelectCompanyUIEvent(this.indexOfCompany);
  @override
  List<Object> get props => [indexOfCompany];
}

class GetCompaniesInfoEvent extends CompanySelectionEvent {}

class ConfirmationOfCompanySelectEvent extends CompanySelectionEvent {}

class SearchAtCompanyEvent extends CompanySelectionEvent {
  final String word;

  const SearchAtCompanyEvent(this.word);
}
