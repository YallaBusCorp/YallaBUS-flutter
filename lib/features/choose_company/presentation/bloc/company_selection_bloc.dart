import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/enitity/company.dart';
import '../../domain/use_case/get_companies_info.dart';

part 'company_selection_event.dart';
part 'company_selection_state.dart';

class CompanySelectionBloc
    extends Bloc<CompanySelectionEvent, CompanySelectionState> {
  GetCompaniesInfo useCase;
  List<Company> companies = [];

  //Here
  List<bool> isSelected = [];
  List<Company> searchedElements = [];
  late String companyName;
  late int companyId;

  CompanySelectionBloc(this.useCase) : super(CompanySelectionInitial()) {
    on<SelectCompanyUIEvent>((event, emit) {
      emit(RefreshSelection());
      for (int i = 0; i < isSelected.length; i++) {
        isSelected[i] = false;
      }
      isSelected[event.indexOfCompany] = !isSelected[event.indexOfCompany];
      companyName = companies[event.indexOfCompany].companyName;
      companyId = companies[event.indexOfCompany].id;
      emit(ChangeSelection());
    });

    on<GetCompaniesInfoEvent>((event, emit) async {
      emit(Loading());
      final l = await useCase.getCompanies();
      l.fold((failure) {
        emit(Error(failure.message));
      }, (allCompanies) {
        companies = allCompanies;
        isSelected = List.generate(allCompanies.length, (index) => false);
        emit(Success(companies));
      });
    });

    on<SearchAtCompanyEvent>((event, emit) {
      searchedElements.clear();
      searchedElements = companies
          .where((element) => element.companyName
              .toLowerCase()
              .contains(event.word.toLowerCase()))
          .toList();
      if (searchedElements.isEmpty) {
        emit(NotFoundCompany());
      } else {
        emit(SuccessSearched(searchedElements));
      }
    });

    on<ConfirmationOfCompanySelectEvent>((event, emit) {
      emit(Confirmation(companyId));
    });
  }
}
