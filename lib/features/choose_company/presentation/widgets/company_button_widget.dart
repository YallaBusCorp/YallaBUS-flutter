import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/resources/colors_manager.dart';
import '../bloc/company_selection_bloc.dart';

import '../../../../core/custom_widgets/button_widget.dart';
import '../../../../core/injection/di.dart';
import '../../../../core/resources/constants_manager.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/values_manager.dart';

class CompanyButton extends StatelessWidget {
  String? edit;
  CompanyButton({Key? key, this.edit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CompanySelectionBloc bloc = BlocProvider.of<CompanySelectionBloc>(context);
    SharedPreferences prefs = di<SharedPreferences>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ValuesManager.v30),
      child: BlocBuilder<CompanySelectionBloc, CompanySelectionState>(
        builder: (context, state) {
          return ButtonWidget(
            onPressed: bloc.isSelected.contains(true)
                ? () {
                    prefs.setInt(ConstantsManager.company, bloc.companyId);
                    bloc.add(ConfirmationOfCompanySelectEvent());
                    if (edit == ConstantsManager.edit) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    } else {
                      Navigator.of(context).pushNamed(Routes.completeProfile);
                    }
                  }
                : null,
            child: Text(
              StringManager.next.tr(),
              style: Theme.of(context).textTheme.headline5,
            ),
          );
        },
      ),
    );
  }
}
