import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/custom_widgets/error_dialog.dart';
import '../../../../../core/custom_widgets/loading_dialog.dart';
import '../bloc/employee_code_bloc.dart';
import '../../../../login_otp/presentation/bloc/Keyboard/keyboard_bloc.dart';
import '../../../../login_otp/presentation/widgets/auth_header_layout.dart';
import '../../../../../core/custom_widgets/success_dialog.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/resources/constants_manager.dart';
import '../../../../../core/resources/routes_manager.dart';
import '../../../../../core/resources/string_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../login_otp/presentation/widgets/auth_keyboard_widget.dart';
import '../widgets/code_button_widget.dart';
import '../widgets/pin_code.dart';

class EmployeeCodeScreen extends StatefulWidget {
  const EmployeeCodeScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeCodeScreen> createState() => _EmployeeCodeScreenState();
}

class _EmployeeCodeScreenState extends State<EmployeeCodeScreen> {
  late KeyboardBloc bloc;
  late EmployeeCodeBloc code;
  @override
  void initState() {
    bloc = BlocProvider.of<KeyboardBloc>(context);
    code = BlocProvider.of<EmployeeCodeBloc>(context);
    code.add(
      GetBusUidEvent(bloc.perfs.getString(ConstantsManager.number)!),
    );
    bloc.indexOfPinNumber = 0;
    bloc.pinCode = "";
    bloc.pins = List.generate(6, (index) => '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 1,
      ),
      body: BlocConsumer<EmployeeCodeBloc, EmployeeCodeState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.busRides, (route) => false);
                });
                return Dialog(
                  backgroundColor: Colors.transparent,
                  child: SuccessDialog(
                    message: 'Welcome back ${code.empName}',
                  ),
                );
              },
            );
          }
          if (state is AuthFailed) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.busRides, (route) => false);
                });
                return Dialog(
                  backgroundColor: Colors.transparent,
                  child: ErrorDialog(
                    message: state.message,
                  ),
                );
              },
            );
          }

          if (state is LoadingCode) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const Dialog(
                  backgroundColor: Colors.transparent,
                  child: LoadingDialog(),
                );
              },
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(ValuesManager.v16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthHeader(
                    header1: 'Identify your role',
                    header2: 'Enter your 6-digit code',
                    asset:
                        StringsExtensions.selectAnimationLightOrDark(context)),
                const Spacer(),
                const Center(child: PinCode()),
                const Spacer(),
                const SizedBox(
                  height: ValuesManager.v10,
                ),
                BlocConsumer<KeyboardBloc, KeyboardState>(
                  listener: (context, state) {
                    if (state is Saved) {}
                  },
                  builder: (context, state) {
                    return SendCodeButton(
                      text: 'Save',
                      onPressed: bloc.indexOfPinNumber == ValuesManager.v6
                          ? () {
                              code.add(
                                SaveEmployeeCodeEvent(bloc.pinCode),
                              );
                              code.add(GetEmployeeEntityEvent(bloc.pinCode));
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
          );
        },
      ),
    );
  }
}
