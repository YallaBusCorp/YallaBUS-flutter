import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/extensions/extensions.dart';

import '../../../../core/resources/constants_manager.dart';

import '../../../../core/resources/values_manager.dart';
import '../bloc/Keyboard/keyboard_bloc.dart';
import '../bloc/Login/login_bloc.dart';
import '../widgets/auth_button_widget.dart';
import '../widgets/auth_header_layout.dart';
import '../widgets/auth_keyboard_widget.dart';
import '../widgets/phone_number_widget.dart';
import '../../../../core/resources/string_manager.dart';

class LoginOtp extends StatefulWidget {
  final String editOrRegister;
  LoginOtp({Key? key, required this.editOrRegister}) : super(key: key);

  @override
  State<LoginOtp> createState() => _LoginOtpState();
}

class _LoginOtpState extends State<LoginOtp> {
  late LoginBloc login;
  late KeyboardBloc keyboard;
  @override
  void initState() {
    login = BlocProvider.of<LoginBloc>(context);
    keyboard = BlocProvider.of<KeyboardBloc>(context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(ValuesManager.v16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthHeader(
              asset: StringsExtensions.selectAnimationLightOrDark(context),
              header1: StringManager.enterYourNumber,
              header2: StringManager.sendYouConfirmation,
            ),
            const Spacer(),
            BlocBuilder<KeyboardBloc, KeyboardState>(
              builder: (context, state) {
                return Center(
                  child: PhoneNumberWidget(num: keyboard.phoneNumber),
                );
              },
            ),
            BlocBuilder<KeyboardBloc, KeyboardState>(
              builder: (context, state) {
                return keyboard.phoneNumber[0] != 0 &&
                        keyboard.phoneNumber[0] != 1 &&
                        keyboard.phoneNumber[0] != 2 &&
                        keyboard.phoneNumber[0] != 5
                    ? Center(
                        child: TextWidget(
                          text: StringManager.numberValidation,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  fontSize: ValuesManager.v14,
                                  color: Colors.red),
                        ),
                      )
                    : Container();
              },
            ),
            BlocBuilder<KeyboardBloc, KeyboardState>(
              builder: (context, state) {
                return AuthButton(
                  edit: widget.editOrRegister,
                  type: StringManager.login,
                  text: StringManager.sendCode.tr(),
                  onPressed: keyboard.indexOfPhoneNumber == ValuesManager.iv9
                      ? () {
                          login.add(SendCodeVerificationEvent(keyboard.number));
                        }
                      : null,
                );
              },
            ),
            const SizedBox(
              height: ValuesManager.v20,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: ValuesManager.v20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: KeyboardWidget(
                  type: ConstantsManager.login,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
