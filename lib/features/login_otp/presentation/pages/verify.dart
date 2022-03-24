import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:yalla_bus/core/custom_widgets/loading_widget.dart';
import 'package:yalla_bus/core/resources/routes_manager.dart';
import 'package:yalla_bus/core/resources/values_manager.dart';
import 'package:yalla_bus/features/login_otp/presentation/widgets/phone_number_widget.dart';
import 'package:yalla_bus/features/login_otp/presentation/widgets/pin_code.dart';
import 'package:yalla_bus/features/login_otp/presentation/widgets/pin_keyboard_widget.dart';

import '../../../../core/custom_widgets/button_widget.dart';
import '../../../../core/resources/asset_manager.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/string_manager.dart';
import '../bloc/login_bloc.dart';
import '../widgets/login_keyboard_widget.dart';

class VerifyScreen extends StatefulWidget {
  final String number;
  const VerifyScreen({Key? key, required this.number}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen>
    with TickerProviderStateMixin {
  late AnimationController _lottieController;

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
                        StringManager.verifyYourNumber,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        StringManager.codeSentTo + widget.number,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Lottie.asset(AssetManager.darkverify,
                    width: ValuesManager.v100, height: ValuesManager.v100),
              ],
            ),
            const SizedBox(
              height: ValuesManager.v80,
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return SizedBox(
                  height: ValuesManager.v55,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: ValuesManager.iv6,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        width: ValuesManager.v12,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return PinCode(pin: bloc.pins[index]);
                    },
                  ),
                );
              },
            ),
            const Spacer(),
            BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
              if (state is Success) {
                Navigator.of(context).pushReplacementNamed(Routes.home);
              } else if (state is Error) {
                return Center(
                  child: Dialog(
                    backgroundColor: ColorsManager.black2,
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            state.message,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          const SizedBox(
                            height: ValuesManager.v10,
                          ),
                          ButtonWidget(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel',
                                style: Theme.of(context).textTheme.subtitle2),
                            height: ValuesManager.v100,
                            width: ValuesManager.v50,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Center(
                child: ElevatedButton(
                  onPressed: bloc.indexOfPinNumber == ValuesManager.v6
                      ? () {
                          String otpCode = bloc.pinCode;
                          bloc.add(VerifyCodeVerificationEvent(otpCode));
                          Navigator.of(context)
                              .pushReplacementNamed(Routes.home);
                        }
                      : null,
                  child: Text(
                    StringManager.verify,
                    style: Theme.of(context).textTheme.bodyText1,
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
            }),
            const SizedBox(
              height: ValuesManager.v10,
            ),
            const PinCodeKeyboardWidget(),
          ],
        ),
      ),
    );
  }
}
