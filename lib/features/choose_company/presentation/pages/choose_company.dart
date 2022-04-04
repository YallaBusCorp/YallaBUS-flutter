import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:yalla_bus/core/custom_widgets/text_form.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';
import 'package:yalla_bus/core/resources/routes_manager.dart';
import 'package:yalla_bus/core/resources/string_manager.dart';
import 'package:yalla_bus/features/choose_company/presentation/bloc/company_selection_bloc.dart';
import '../../../../core/custom_widgets/animation_widget.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/values_manager.dart';
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
  Widget build(BuildContext context) {
    CompanySelectionBloc bloc = BlocProvider.of<CompanySelectionBloc>(context);
    return Scaffold(
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
              //HereT
              const TextFormWidget(
                text: StringManager.search,
                width: double.infinity,
                icon: Icons.search,
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<CompanySelectionBloc, CompanySelectionState>(
                builder: (context, state) {
                  return Expanded(
                    child: SizedBox(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: bloc.companies.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: ValuesManager.v10,
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return CompanyItem(
                            index: index,
                            bloc: bloc,
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: ValuesManager.v10,
              ),

              Text(
                'NOTE: If you don\'t have an account yet, choose the company that you want to subscipe to at',
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Colors.grey),
              ),
              const SizedBox(
                height: ValuesManager.v10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: ValuesManager.v30),
                child: BlocBuilder<CompanySelectionBloc, CompanySelectionState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                            MediaQuery.of(context).size.width -
                                ValuesManager.v50,
                            ValuesManager.v45),
                        primary: ColorsManager.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(ValuesManager.v16),
                        ),
                      ),
                      onPressed: bloc.isSelected.contains(true)
                          ? () {
                              Navigator.of(context).pushNamed(Routes.loginOtp);
                            }
                          : null,
                      child: Text(
                        StringManager.next.tr(),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    );
                  },
                ),
              ),
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
