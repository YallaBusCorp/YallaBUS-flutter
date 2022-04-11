import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:yalla_bus/core/custom_widgets/button_widget.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';
import 'package:yalla_bus/core/resources/routes_manager.dart';
import 'package:yalla_bus/core/resources/string_manager.dart';
import 'package:yalla_bus/features/choose_company/presentation/bloc/company_selection_bloc.dart';
import 'package:yalla_bus/features/choose_company/presentation/widgets/company_button_widget.dart';
import 'package:yalla_bus/features/choose_company/presentation/widgets/company_list_view.dart';
import 'package:yalla_bus/features/choose_company/presentation/widgets/loading_bus_widget.dart';
import 'package:yalla_bus/features/choose_company/presentation/widgets/not_found_widget.dart';
import 'package:yalla_bus/features/choose_company/presentation/widgets/search_field.dart';
import '../../../../core/custom_widgets/animation_widget.dart';
import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/injection/di.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../widgets/companies_bloc_consumer_widget.dart';
import '../widgets/company_item.dart';

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
