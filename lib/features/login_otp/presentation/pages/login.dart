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
import 'package:yalla_bus/features/login_otp/presentation/bloc/login_bloc.dart';
import 'package:yalla_bus/features/login_otp/presentation/pages/verify.dart';
import 'package:yalla_bus/features/login_otp/presentation/widgets/login_keyboard_widget.dart';
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

class _LoginOtpState extends State<LoginOtp> with TickerProviderStateMixin {
  late AnimationController _lottieController;
  late String _verificationId;

  @override
  void initState() {
    _lottieController = AnimationController(
      vsync: this,
      upperBound: ValuesManager.vZeroPointSeven,
      duration: Duration(milliseconds: ValuesManager.v500.toInt()),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LoginBloc bloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(ValuesManager.v16),
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
                        StringManager.enterYourNumber.tr(),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        StringManager.sendYouConfirmation.tr(),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
                Lottie.asset(AssetManager.darkverify,
                    width: ValuesManager.v100, height: ValuesManager.v100),
              ],
            ),
            const Spacer(),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return Center(
                  child: PhoneNumberWidget(
                    num: bloc.phoneNumber,
                  ),
                );
              },
            ),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is SendingData) {
                  DialogWidget(context, 'Wait a while ...', 'Loading');
                } else if (state is Success) {
                  Navigator.of(context, rootNavigator: true).pop();
                  Navigator.of(context)
                      .pushNamed(Routes.verifyOtp, arguments: bloc.number);
                } else if (state is Error) {
                  // Navigator.of(context, rootNavigator: true).pop();
                  DialogWidget(context, state.message, 'Error');
                }
              },
              builder: (context, state) {
                return Center(
                  child: ElevatedButton(
                    onPressed: bloc.indexOfPhoneNumber == ValuesManager.v9
                        ? () {
                            String number = bloc.number;
                            bloc.add(SendCodeVerificationEvent(number));
                          }
                        : null,
                    child: Text(
                      StringManager.confirm.tr(),
                      style: Theme.of(context).textTheme.bodyText2,
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
            ),
            const SizedBox(
              height: 20,
            ),
            const Align(
                alignment: Alignment.bottomCenter,
                child: LoginKeyboardWidget()),
          ],
        ),
      ),
    );
  }
}
