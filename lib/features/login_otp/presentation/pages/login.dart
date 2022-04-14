import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yalla_bus/core/custom_widgets/text_widget.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';

import 'package:yalla_bus/core/resources/constants_manager.dart';

import 'package:yalla_bus/core/resources/values_manager.dart';
import 'package:yalla_bus/features/login_otp/presentation/bloc/Keyboard/keyboard_bloc.dart';
import 'package:yalla_bus/features/login_otp/presentation/bloc/Login/login_bloc.dart';
import 'package:yalla_bus/features/login_otp/presentation/widgets/auth_button_widget.dart';
import 'package:yalla_bus/features/login_otp/presentation/widgets/auth_header_layout.dart';
import 'package:yalla_bus/features/login_otp/presentation/widgets/auth_keyboard_widget.dart';
import 'package:yalla_bus/features/login_otp/presentation/widgets/phone_number_widget.dart';

import '../../../../core/resources/string_manager.dart';

class LoginOtp extends StatefulWidget {
  const LoginOtp({Key? key}) : super(key: key);

  @override
  State<LoginOtp> createState() => _LoginOtpState();
}

class _LoginOtpState extends State<LoginOtp> {
  @override
  Widget build(BuildContext context) {
    LoginBloc bloc = BlocProvider.of<LoginBloc>(context);
    KeyboardBloc keyboard = BlocProvider.of<KeyboardBloc>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(ValuesManager.v16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthHeader(
              asset: selectAnimationLightOrDark(context),
              header1: StringManager.enterYourNumber,
              header2: StringManager.sendYouConfirmation,
            ),
            const Spacer(),
            BlocBuilder<KeyboardBloc, KeyboardState>(
              builder: (context, state) {
                return Center(
                  child: PhoneNumberWidget(
                    num: keyboard.phoneNumber,
                  ),
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
                          text: 'Number must start with 010, 011, 012 or 015',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontSize: 14, color: Colors.red),
                        ),
                      )
                    : Container();
              },
            ),
            BlocBuilder<KeyboardBloc, KeyboardState>(
              builder: (context, state) {
                return AuthButton(
                  type: StringManager.login,
                  text: StringManager.sendCode.tr(),
                  onPressed: keyboard.indexOfPhoneNumber == ValuesManager.iv9
                      ? () {
                          bloc.add(SendCodeVerificationEvent(keyboard.number));
                        }
                      : null,
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding:  EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child:  KeyboardWidget(
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
