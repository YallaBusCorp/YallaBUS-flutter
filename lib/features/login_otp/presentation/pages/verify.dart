import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:yalla_bus/core/custom_widgets/loading_widget.dart';
import 'package:yalla_bus/core/resources/routes_manager.dart';
import 'package:yalla_bus/features/login_otp/presentation/widgets/phone_number_widget.dart';
import 'package:yalla_bus/features/login_otp/presentation/widgets/pin_code.dart';

import '../../../../core/resources/asset_manager.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/string_manager.dart';
import '../bloc/login_bloc.dart';
import '../widgets/keyboard_widget.dart';

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
      upperBound: 0.7,
      duration: const Duration(milliseconds: 500),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LoginBloc bloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      appBar: AppBar(),
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
                Lottie.asset(AssetManager.darkverify, width: 100, height: 100),
              ],
            ),
            const SizedBox(
              height: 80,
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return SizedBox(
                  height: 55,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        width: 12,
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
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is Success) {
                  Navigator.of(context).pushReplacementNamed(Routes.home);
                } else if (state is Error) {
                  return Center(
                    child : Container(
                      width: 200,
                      height: 100,
                      decoration: BoxDecoration(
                        color: ColorsManager.black2,
                        borderRadius: BorderRadius.circular(18),

                      ),
                      child : Center(
                          child: Text(
                        'Error',
                        style: Theme.of(context).textTheme.bodyText2,
                      ), ),
                    
                    ),
                  );
                } 
                  return Center(
                    child: ElevatedButton(
                      onPressed: bloc.indexOfPinNumber == 6
                          ? () {
                              String otpCode = getOtpCode(bloc.pins);
                              bloc.add(VerifyCodeVerification(otpCode));
                            }
                          : null,
                      child: Text(
                        StringManager.verify,
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
                }
        
            ),
            const SizedBox(
              height: 10,
            ),
            const KeyboardWidget(
              type: StringManager.verify,
            ),
          ],
        ),
      ),
    );
  }

  String getOtpCode(List<String> otpCode) {
    String code = "";
    for (int i = 0; i < otpCode.length; i++) {
      code += otpCode[i];
    }
    return code;
  }
}
