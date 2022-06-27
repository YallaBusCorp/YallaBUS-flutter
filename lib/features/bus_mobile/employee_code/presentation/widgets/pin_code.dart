import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_bus/features/bus_mobile/employee_code/presentation/bloc/employee_code_bloc.dart';

import '../../../../../core/resources/values_manager.dart';
import '../../../../login_otp/presentation/widgets/pin_layout.dart';

class PinCode extends StatelessWidget {
  const PinCode({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    EmployeeCodeBloc keyboard = BlocProvider.of<EmployeeCodeBloc>(context);
    return BlocBuilder<EmployeeCodeBloc, EmployeeCodeState>(
      builder: (context, state) {
        return SizedBox(
          height: ValuesManager.v55,
          child: Center(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: ValuesManager.iv4,
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
