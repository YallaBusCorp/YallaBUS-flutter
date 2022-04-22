import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_bus/features/login_otp/presentation/bloc/Keyboard/keyboard_bloc.dart';
import 'package:yalla_bus/features/login_otp/presentation/widgets/pin_layout.dart';

import '../../../../core/resources/values_manager.dart';

class PinCode extends StatelessWidget {
  PinCode({Key? key}) : super(key: key);
  final List<String> pins = List.generate(6, (index) => '');
  @override
  Widget build(BuildContext context) {
    KeyboardBloc keyboard = BlocProvider.of<KeyboardBloc>(context);
    return BlocBuilder<KeyboardBloc, KeyboardState>(
      builder: (context, state) {
        return SizedBox(
          height: ValuesManager.v55,
          child: Center(
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
          ),
        );
      },
    );
  }
}
