part of 'company_selection_bloc.dart';

abstract class CompanySelectionState extends Equatable {
  const CompanySelectionState();

  @override
  List<Object> get props => [];
}

class CompanySelectionInitial extends CompanySelectionState {}

class Loading extends CompanySelectionState {}

class ChangeSelection extends CompanySelectionState {}

class NotFoundCompany extends CompanySelectionState {}

class RefreshSelection extends CompanySelectionState {}

class Confirmation extends CompanySelectionState {
  final int id;

  const Confirmation(this.id);

}

class SuccessSearched extends CompanySelectionState {
  final List<Company> searchedList;

  const SuccessSearched(this.searchedList);
  @override
  List<Object> get props => [searchedList];
}

class Success extends CompanySelectionState {
  final List<Company> allCompanyList;

  const Success(this.allCompanyList);
  @override
  List<Object> get props => [allCompanyList];
}

class Error extends CompanySelectionState {
  final String message;

  const Error(this.message);
  @override
  List<Object> get props => [message];
}

// enum CompanyStatus {
//   initial,
//   loading,
//   success,
//   successSearching,
//   error,
//   notFound,
//   changeSelection
// }

// class CompanyState extends Equatable {
//   late CompanyStatus? status;
//   late String? message;
//   late List<Company>? searchedList;
//   late List<Company>? list;

//   CompanyState({this.status, this.message, this.searchedList, this.list});

//   CompanyState copyWith({
//     CompanyStatus? status,
//     String? message,
//     List<Company>? searchedList,
//     List<Company>? list,
//   }) {
//     return CompanyState(
//       status: status ?? this.status,
//       message: message ?? this.message,
//       searchedList: searchedList ?? this.searchedList,
//       list: list ?? this.list,
//     );
//   }

//   @override
//   List<Object?> get props => [status];
// }
