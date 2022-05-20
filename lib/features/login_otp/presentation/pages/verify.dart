import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../bloc/Keyboard/keyboard_bloc.dart';
import '../bloc/Login/login_bloc.dart';
import '../widgets/auth_button_widget.dart';
import '../widgets/auth_header_layout.dart';
import '../widgets/auth_keyboard_widget.dart';
import '../widgets/pin_code.dart';

class VerifyScreen extends StatefulWidget {
  final String number;
  const VerifyScreen({Key? key, required this.number}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  @override
  void didChangeDependencies() {
    KeyboardBloc bloc = BlocProvider.of<KeyboardBloc>(context);
    for (int i = 0; i < 9; i++) {
      bloc.add(RemovePinNumberEvent());
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    LoginBloc bloc = BlocProvider.of<LoginBloc>(context);
    KeyboardBloc keyboard = BlocProvider.of<KeyboardBloc>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
      ),
      body: Padding(
        padding: const EdgeInsets.all(ValuesManager.v16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthHeader(
                header1: StringManager.verifyYourNumber.tr(),
                header2: StringManager.codeSentTo.tr() + keyboard.number,
                asset: selectAnimationLightOrDark(context)),
            const Spacer(),
            PinCode(),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: ValuesManager.v15),
              child: Center(
                child: TextWidget(
                  text: StringManager.resendCode.tr(),
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontSize: ValuesManager.v14, color: ColorsManager.orange),
                ),
              ),
            ),
            const SizedBox(
              height: ValuesManager.v10,
            ),
            BlocBuilder<KeyboardBloc, KeyboardState>(
              builder: (context, state) {
                return AuthButton(
                  type: StringManager.otp,
                  text: StringManager.verify.tr(),
                  onPressed: keyboard.indexOfPinNumber == ValuesManager.v6
                      ? () {
                          bloc.add(
                            VerifyCodeVerificationEvent(keyboard.pinCode),
                          );
                        }
                      : null,
                );
              },
            ),
            const SizedBox(
              height: ValuesManager.v20,
            ),
            const KeyboardWidget(
              type: StringManager.otp,
            ),
          ],
        ),
      ),
    );
  }
}
