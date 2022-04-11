import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_bus/core/resources/colors_manager.dart';
import 'package:yalla_bus/features/choose_company/presentation/bloc/company_selection_bloc.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/values_manager.dart';

class SearchField extends StatefulWidget {
  SearchField({Key? key}) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CompanySelectionBloc bloc = BlocProvider.of<CompanySelectionBloc>(context);
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 15,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: ValuesManager.v5),
          child: TextFormField(
            cursorColor: ColorsManager.orange,
            controller: _controller,
            decoration: TextFormStyle.applyDecoration(
                StringManager.search.tr(), Icons.search, context),
            onChanged: (String newValue) {
              bloc.add(SearchAtCompanyEvent(newValue));
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
