import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_bus/features/bus_mobile/employee_code/presentation/bloc/employee_code_bloc.dart';
import 'package:yalla_bus/features/login_otp/presentation/bloc/Keyboard/keyboard_bloc.dart';

import '../../../../../core/resources/values_manager.dart';
import '../../../../login_otp/presentation/widgets/pin_layout.dart';

class PinCode extends StatefulWidget {
  const PinCode({Key? key}) : super(key: key);

  @override
  State<PinCode> createState() => _PinCodeState();
}

class _PinCodeState extends State<PinCode> {
  late KeyboardBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<KeyboardBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                return PinLayout(pin: bloc.pins[index]);
              },
            ),
          ),
        );
      },
    );
  }
}
