import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_bus/core/resources/colors_manager.dart';

import '../../../../core/custom_widgets/button_widget.dart';
import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/resources/routes_manager.dart';
import '../bloc/settings_bloc.dart';

class SignOutDialogButtons extends StatelessWidget {
  const SignOutDialogButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsBloc bloc = BlocProvider.of<SettingsBloc>(context);
    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is SignOutSuccess) {
          Navigator.of(context).pop();
          Navigator.of(context).pushNamedAndRemoveUntil(Routes.goodBye, (route) => false);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ButtonWidget(
            onPressed: () {
              bloc.add(SignOutEvent());
            },
            child: TextWidget(
              text: 'Yes',
              style:
                  Theme.of(context).textTheme.headline5!.copyWith(fontSize: 18),
            ),
            color: ColorsManager.green,
            width: 100,
          ),
          ButtonWidget(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: TextWidget(
              text: 'No',
              style:
                  Theme.of(context).textTheme.headline5!.copyWith(fontSize: 18),
            ),
            color: ColorsManager.offRed,
            width: 100,
          ),
        ],
      ),
    );
  }
}
