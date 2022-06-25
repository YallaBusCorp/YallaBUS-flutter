import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';
import '../../../../core/custom_widgets/button_widget.dart';
import '../../../../core/custom_widgets/loading_dialog.dart';
import '../../../../core/custom_widgets/success_dialog.dart';
import '../../../../core/resources/asset_manager.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../../core/injection/di.dart' as sl;
import '../../../../core/resources/string_manager.dart';
import '../../../login_otp/presentation/bloc/Keyboard/keyboard_bloc.dart';

import '../../../../core/custom_widgets/error_dialog.dart';
import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/injection/di.dart';
import '../../../../core/resources/values_manager.dart';

class GoodBye extends StatefulWidget {
  const GoodBye({Key? key}) : super(key: key);

  @override
  State<GoodBye> createState() => _GoodByeState();
}

class _GoodByeState extends State<GoodBye> {
  @override
  void didChangeDependencies() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.loginOtp, (route) => false,
          arguments: ConstantsManager.register);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Lottie.asset(AssetManager.guyWaving, width: 350, height: 350),
            const SizedBox(
              height: ValuesManager.v10,
            ),
            TextWidget(
              text: 'GoodBye! We wish to see you again!',
              style: Theme.of(context).textTheme.headline6!,
            ),
          ],
        ),
      ),
    );
  }
}
