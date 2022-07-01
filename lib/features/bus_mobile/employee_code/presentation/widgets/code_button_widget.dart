import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/custom_widgets/error_dialog.dart';
import '../../../../../core/custom_widgets/loading_dialog.dart';
import '../../../../../core/resources/colors_manager.dart';
import '../../../../../core/resources/routes_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/states/state.dart';
import '../bloc/employee_code_bloc.dart';

class SendCodeButton extends StatefulWidget {
  final String text;
  final GestureTapCallback? onPressed;
  const SendCodeButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<SendCodeButton> createState() => _SendCodeButtonState();
}

class _SendCodeButtonState extends State<SendCodeButton> {
  late EmployeeCodeBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<EmployeeCodeBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeCodeBloc, EmployeeCodeState>(
      listener: (context, state) {
        if (state is LoadingCode) {
          showDialog(
            context: context,
            builder: (BuildContext context) => const Dialog(
              backgroundColor: Colors.transparent,
              child: LoadingDialog(),
            ),
          );
        } else if (state is Success) {
          Navigator.of(context).pop();
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Routes.busRides, (route) => false);
        } else if (state is Error) {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (BuildContext context) => Dialog(
              insetPadding: const EdgeInsets.all(25),
              backgroundColor: Colors.transparent,
              child: ErrorDialog(
                message: 'Failed Authorization',
                onTap: widget.onPressed,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Center(
          child: ElevatedButton(
            onPressed: widget.onPressed,
            child: Text(
              widget.text.tr(),
              style: Theme.of(context).textTheme.headline5,
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
      },
    );
  }
}
