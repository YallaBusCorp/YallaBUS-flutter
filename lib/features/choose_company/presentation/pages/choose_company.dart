import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../bloc/company_selection_bloc.dart';
import '../widgets/companies_bloc_consumer_widget.dart';
import '../widgets/company_button_widget.dart';
import '../widgets/search_field.dart';

class ChooseCompany extends StatefulWidget {
  const ChooseCompany({Key? key}) : super(key: key);

  @override
  State<ChooseCompany> createState() => _ChooseCompanyState();
}

class _ChooseCompanyState extends State<ChooseCompany>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: ValuesManager.v500.toInt()),
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    CompanySelectionBloc bloc = BlocProvider.of<CompanySelectionBloc>(context);
    bloc.add(GetCompaniesInfoEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          StringManager.chooseCompany.tr(),
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(ValuesManager.v16),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SearchField(),
              const SizedBox(
                height: ValuesManager.v20,
              ),
              const Expanded(child: CompaniesView()),
              const SizedBox(
                height: ValuesManager.v10,
              ),
              TextWidget(
                text: StringManager.companyNote.tr(),
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Colors.grey),
              ),
              const SizedBox(
                height: ValuesManager.v10,
              ),
              const CompanyButton(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
