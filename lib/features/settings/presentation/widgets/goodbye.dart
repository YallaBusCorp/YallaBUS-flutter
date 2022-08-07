import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/resources/asset_manager.dart';
import '../../../../core/resources/constants_manager.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../bloc/settings_bloc.dart';

class GoodBye extends StatefulWidget {
  const GoodBye({Key? key}) : super(key: key);

  @override
  State<GoodBye> createState() => _GoodByeState();
}

class _GoodByeState extends State<GoodBye> {
  late SettingsBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<SettingsBloc>(context);
    Future.delayed(const Duration(seconds: 3), () {
      bloc.add(SignOutEvent());
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.loginOtp, (route) => false,
          arguments: ConstantsManager.register);
    });
    super.initState();
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
