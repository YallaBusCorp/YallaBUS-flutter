import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_bus/core/custom_widgets/show_dialog.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';
import 'package:yalla_bus/features/choose_company/presentation/bloc/company_selection_bloc.dart';
import 'package:yalla_bus/features/choose_company/presentation/widgets/company_list_view.dart';
import 'package:yalla_bus/features/choose_company/presentation/widgets/loading_bus_widget.dart';
import 'package:yalla_bus/features/choose_company/presentation/widgets/not_found_widget.dart';

class CompaniesView extends StatelessWidget {
  const CompaniesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CompanySelectionBloc bloc = BlocProvider.of<CompanySelectionBloc>(context);
    return BlocConsumer<CompanySelectionBloc, CompanySelectionState>(
      listener: (context, state) {
        if (state is Error) {
          DialogWidget(context, state.message, ConstantsManager.error);
        }
      },
      builder: (context, state) {
        if (state is Loading) {
          return const LoadingBusWidget();
        } else if (state is Success) {
          return CompaniesListView(
            companies: state.allCompanyList,
          );
        } else if (state is SuccessSearched) {
          return CompaniesListView(
            companies: state.searchedList,
          );
        } else if (state is NotFoundCompany) {
          return const NotFoundWidget();
        }
        return CompaniesListView(
          companies: bloc.companies,
        );
      },
    );
  }
}
