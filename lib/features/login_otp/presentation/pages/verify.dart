import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:yalla_bus/core/custom_widgets/loading_widget.dart';
import 'package:yalla_bus/core/resources/routes_manager.dart';
import 'package:yalla_bus/core/resources/values_manager.dart';
import 'package:yalla_bus/features/login_otp/presentation/bloc/Keyboard/keyboard_bloc.dart';
import 'package:yalla_bus/features/login_otp/presentation/widgets/Auth_button_widget.dart';
import 'package:yalla_bus/features/login_otp/presentation/widgets/Auth_header_layout.dart';
import 'package:yalla_bus/features/login_otp/presentation/widgets/phone_number_widget.dart';
import 'package:yalla_bus/features/login_otp/presentation/widgets/pin_code.dart';
import 'package:yalla_bus/features/login_otp/presentation/widgets/pin_layout.dart';

import '../../../../core/custom_widgets/button_widget.dart';
import '../../../../core/custom_widgets/show_dialog.dart';
import '../../../../core/resources/asset_manager.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../home/presentation/pages/home.dart';
import '../bloc/Login/login_bloc.dart';
import '../widgets/Auth_keyboard_widget.dart';

class VerifyScreen extends StatefulWidget {
  final String number;
  const VerifyScreen({Key? key, required this.number}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
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
                header1: StringManager.verifyYourNumber,
                header2: StringManager.codeSentTo + keyboard.number,
                asset: AssetManager.darkverify),
            const SizedBox(
              height: ValuesManager.v80,
            ),
            const PinCode(),
            const Spacer(),
            AuthButton(
                text: StringManager.sendCode,
                onPressed: () {
                  keyboard.indexOfPinNumber == ValuesManager.v5
                      ? bloc.add(
                          VerifyCodeVerificationEvent(keyboard.pinCode),
                        )
                      : null;
                }),
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