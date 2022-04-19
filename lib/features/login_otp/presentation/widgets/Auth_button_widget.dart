import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';

import '../../../../core/custom_widgets/show_dialog.dart';
import '../../../../core/injection/di.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../bloc/Keyboard/keyboard_bloc.dart';
import '../bloc/Login/login_bloc.dart';

class AuthButton extends StatelessWidget {
  // add type properity
  final String type;
  final String text;
  final GestureTapCallback? onPressed;
  const AuthButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SharedPreferences perfs = di<SharedPreferences>();
    KeyboardBloc keyboard = BlocProvider.of<KeyboardBloc>(context);
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is SendingData) {
          DialogWidget(context, StringManager.wait, ConstantsManager.loading);
        } else if (state is Success) {
          Navigator.of(context).pop();
          if (type == StringManager.otp) {
            if (perfs.getInt(ConstantsManager.company) == null) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.chooseCompany, (route) => false);
            } else {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Routes.home, (route) => false);
            }
          } else {
            Navigator.of(context)
                .pushNamed(Routes.verifyOtp, arguments: keyboard.number);
          }
        } else if (state is Error) {
          Navigator.of(context).pop();
          DialogWidget(context, state.message, ConstantsManager.error);
        }
      },
      builder: (context, state) {
        return Center(
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(
              text.tr(),
              style: Theme.of(context).textTheme.headline5,
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(
                  MediaQuery.of(context).size.width - ValuesManager.v50,
                  ValuesManager.v45),
              primary: ColorsManager.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ValuesManager.v16),
              ),
            ),
          ),
        );
      },
    );
  }
}
