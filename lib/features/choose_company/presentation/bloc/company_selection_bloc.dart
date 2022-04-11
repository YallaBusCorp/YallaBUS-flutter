import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:yalla_bus/features/choose_company/domain/enitity/company.dart';
import 'package:yalla_bus/features/choose_company/domain/use_case/get_companies_info.dart';
import 'package:yalla_bus/core/injection/di.dart' as sl;
import '../../../../core/resources/string_manager.dart';

part 'company_selection_event.dart';
part 'company_selection_state.dart';

class CompanySelectionBloc
    extends Bloc<CompanySelectionEvent, CompanySelectionState> {
  GetCompaniesInfo useCase;
  List<Company> companies = [];

  @override
  void onChange(Change<CompanySelectionState> change) {
    super.onChange(change);
    print(change);
  }

  //Here
  List<bool> isSelected = [];
  List<Company> searchedElements = [];

  CompanySelectionBloc(this.useCase) : super(CompanySelectionInitial()) {
    on<SelectCompanyEvent>((event, emit) {
    emit(RefreshSelection());
      for (int i = 0; i < isSelected.length; i++) {
        isSelected[i] = false;
      }
      isSelected[event.indexOfCompany] = !isSelected[event.indexOfCompany];
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
  }
}
