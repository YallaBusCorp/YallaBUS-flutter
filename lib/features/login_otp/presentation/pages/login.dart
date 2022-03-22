import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:yalla_bus/core/custom_widgets/animation_widget.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';
import 'package:yalla_bus/features/login_otp/presentation/bloc/login_bloc.dart';
import 'package:yalla_bus/features/login_otp/presentation/widgets/keyboard_widget.dart';
import 'package:yalla_bus/features/login_otp/presentation/widgets/phone_number_widget.dart';

import '../../../../core/custom_widgets/button_widget.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/string_manager.dart';

class LoginOtp extends StatefulWidget {
  const LoginOtp({Key? key}) : super(key: key);

  @override
  State<LoginOtp> createState() => _LoginOtpState();
}

class _LoginOtpState extends State<LoginOtp> with TickerProviderStateMixin {
  late AnimationController _lottieController;

  @override
  void initState() {
    _lottieController = AnimationController(
      vsync: this,
      upperBound: 0.7,
      duration: const Duration(milliseconds: 500),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LoginBloc bloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        StringManager.enterYourNumber,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        StringManager.sendYouConfirmation,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
                Lottie.asset(AssetManager.darkverify, width: 100, height: 100),
              ],
            ),
            const SizedBox(
              height: 80,
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return Center(
                  child: PhoneNumberWidget(
                    num: bloc.phoneNumber,
                  ),
                );
              },
            ),
            const Spacer(),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return Center(
                  child: ElevatedButton(
                    onPressed: bloc.index == 7 ? () {} : null,
                    child: Text(
                      StringManager.confirm,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize:
                          Size(MediaQuery.of(context).size.width - 50, 46),
                      primary: ColorsManager.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const KeyboardWidget(),
          ],
        ),
      ),
    );
  }
}
