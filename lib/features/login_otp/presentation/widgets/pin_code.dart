import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_bus/features/login_otp/presentation/bloc/Keyboard/keyboard_bloc.dart';
import 'package:yalla_bus/features/login_otp/presentation/widgets/pin_layout.dart';

import '../../../../core/custom_widgets/show_dialog.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../home/presentation/pages/home.dart';
import '../bloc/Login/login_bloc.dart';

class PinCode extends StatelessWidget {
  const PinCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    KeyboardBloc keyboard = BlocProvider.of<KeyboardBloc>(context);
    return BlocBuilder<KeyboardBloc, KeyboardState>(
      builder: (context, state) {
        return SizedBox(
          height: ValuesManager.v55,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: ValuesManager.iv6,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                width: ValuesManager.v10,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return PinLayout(pin: keyboard.pins[index]);
            },
          ),
        );
      },
    );
  }
}
