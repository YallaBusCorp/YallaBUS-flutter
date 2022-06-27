import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_bus/features/bus_mobile/employee_code/presentation/bloc/employee_code_bloc.dart';

import '../../../../../core/custom_widgets/text_widget.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/resources/string_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../login_otp/presentation/widgets/auth_button_widget.dart';
import '../../../../login_otp/presentation/widgets/auth_keyboard_widget.dart';
import '../widgets/code_button_widget.dart';
import '../widgets/pin_code.dart';

class EmployeeCodeScreen extends StatefulWidget {
  const EmployeeCodeScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeCodeScreen> createState() => _EmployeeCodeScreenState();
}

class _EmployeeCodeScreenState extends State<EmployeeCodeScreen> {
  late EmployeeCodeBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<EmployeeCodeBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
      ),
      body: Padding(
        padding: const EdgeInsets.all(ValuesManager.v16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your 4-digit code',
              style: Theme.of(context).textTheme.headline5,
            ),
            const Spacer(),
            const PinCode(),
            const Spacer(),
            const SizedBox(
              height: ValuesManager.v10,
            ),
            BlocBuilder<EmployeeCodeBloc, EmployeeCodeState>(
              builder: (context, state) {
                return SendCodeButton(
                  text: StringManager.verify.tr(),
                  onPressed: bloc.indexOfPinNumber == ValuesManager.v6
                      ? () {
                          bloc.add(
                            SaveEmployeeCodeEvent(bloc.pinCode),
                          );
                        }
                      : null,
                );
              },
            ),
            const SizedBox(
              height: ValuesManager.v20,
            ),
            const KeyboardWidget(
              type: StringManager.otp,
            ),
          ],
        ),
      ),
    );
  }
}
