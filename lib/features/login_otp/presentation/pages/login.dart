import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:yalla_bus/core/custom_widgets/animation_widget.dart';
import 'package:yalla_bus/core/custom_widgets/show_dialog.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';
import 'package:yalla_bus/core/resources/routes_manager.dart';
import 'package:yalla_bus/core/resources/values_manager.dart';
import 'package:yalla_bus/features/login_otp/presentation/bloc/Keyboard/keyboard_bloc.dart';
import 'package:yalla_bus/features/login_otp/presentation/bloc/Login/login_bloc.dart';
import 'package:yalla_bus/features/login_otp/presentation/pages/verify.dart';
import 'package:yalla_bus/features/login_otp/presentation/widgets/Auth_button_widget.dart';
import 'package:yalla_bus/features/login_otp/presentation/widgets/Auth_header_layout.dart';
import 'package:yalla_bus/features/login_otp/presentation/widgets/Auth_keyboard_widget.dart';
import 'package:yalla_bus/features/login_otp/presentation/widgets/phone_number_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/custom_widgets/button_widget.dart';
import '../../../../core/custom_widgets/loading_widget.dart';
import '../../../../core/resources/colors_manager.dart';
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
            const AuthHeader(
              asset: AssetManager.darkverify,
              header1: StringManager.enterYourNumber,
              header2: StringManager.enterYourNumber,
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
            AuthButton(
              text: StringManager.sendCode,
              onPressed: () {
                keyboard.indexOfPhoneNumber == ValuesManager.v8
                    ? bloc.add(SendCodeVerificationEvent(keyboard.number))
                    : null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: KeyboardWidget(
                type: ConstantsManager.login,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
