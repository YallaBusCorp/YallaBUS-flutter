import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/resources/string_manager.dart';

part 'company_selection_event.dart';
part 'company_selection_state.dart';

class CompanySelectionBloc
    extends Bloc<CompanySelectionEvent, CompanySelectionState> {
  List<String> companies = [
    StringManager.companyNo1.tr(),
    StringManager.companyNo2.tr(),
    StringManager.companyNo3.tr(),
    StringManager.companyNo4.tr(),
    StringManager.companyNo5.tr(),
    StringManager.companyNo6.tr(),
    StringManager.companyNo6.tr(),
    StringManager.companyNo7.tr(),
  ];

  List<bool> isSelected = List.generate(8, (index) => false);
  List<String> searchedElements = [];
  bool isClicked = false;

  CompanySelectionBloc() : super(CompanySelectionInitial()) {
    on<SelectCompanyEvent>((event, emit) {
      emit(Loading());
      for (int i = 0; i < isSelected.length; i++) {
        isSelected[i] = false;
      }
      isSelected[event.indexOfCompany] = !isSelected[event.indexOfCompany];
      emit(ChangeSelection());
    });

    on<ConfirmationOfCompanySelectEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SearchAtCompanyEvent>((event, emit) {
      emit(Loading());
      searchedElements.clear();
      searchedElements =
          companies.where((element) => element.contains(event.word)).toList();
      if (searchedElements.isEmpty) {
        emit(NotFoundCompany());
      } else {
        emit(Success());
      }
    });
  }
}
