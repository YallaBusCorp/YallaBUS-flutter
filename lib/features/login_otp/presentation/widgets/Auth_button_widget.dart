import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/custom_widgets/loading_dialog.dart';
import '../../../../core/resources/constants_manager.dart';
import '../../../../core/custom_widgets/error_dialog.dart';
import '../../../../core/injection/di.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../bloc/Keyboard/keyboard_bloc.dart';
import '../bloc/Login/login_bloc.dart';

class AuthButton extends StatelessWidget {
  // add type properity
  String? edit;
  final String type;
  final String text;
  final GestureTapCallback? onPressed;
  AuthButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.type,
      this.edit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SharedPreferences perfs = di<SharedPreferences>();
    KeyboardBloc keyboard = BlocProvider.of<KeyboardBloc>(context);
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is SendingData) {
          showDialog(
            context: context,
            builder: (BuildContext context) => const Dialog(
              backgroundColor: Colors.transparent,
              child: LoadingDialog(),
            ),
          );
        } else if (state is Success) {
          Navigator.of(context).pop();
          if (type == StringManager.otp) {
            if (edit == ConstantsManager.edit) {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            } else if (perfs.getInt(ConstantsManager.company) == null) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.chooseCompany, (route) => false,
                  arguments: ConstantsManager.register);
            } else if (perfs.getInt(ConstantsManager.company) != null) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Routes.home, (route) => false);
            } else {}
          } else {
            Navigator.of(context)
                .pushNamed(Routes.verifyOtp, arguments: keyboard.number);
          }
        } else if (state is Error) {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (BuildContext context) => Dialog(
              insetPadding: const EdgeInsets.all(25),
              backgroundColor: Colors.transparent,
              child: ErrorDialog(
                message: 'Try again in another time!',
                onTap: onPressed,
              ),
            ),
          );
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
