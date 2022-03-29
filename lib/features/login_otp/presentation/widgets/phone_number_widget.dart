import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_bus/core/resources/string_manager.dart';
import 'package:yalla_bus/core/resources/values_manager.dart';
import 'package:yalla_bus/features/login_otp/presentation/bloc/login_bloc.dart';

class PhoneNumberWidget extends StatefulWidget {
  List<int> num;
  PhoneNumberWidget({Key? key, required this.num}) : super(key: key);

  @override
  State<PhoneNumberWidget> createState() => _PhoneNumberWidgetState();
}

class _PhoneNumberWidgetState extends State<PhoneNumberWidget> {
  @override
  Widget build(BuildContext context) {
    LoginBloc bloc = BlocProvider.of<LoginBloc>(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringManager.plusOperator,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 40),
        ),
        Text(ValuesManager.iv2.toString(),
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 40)),
        Text(ValuesManager.iv0.toString(),
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 40)),
        const SizedBox(
          width: ValuesManager.v10,
        ),
        Text(ValuesManager.iv1.toString(),
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 40)),
        SizedBox(
          height: ValuesManager.v100,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.num.length,
            itemBuilder: (BuildContext context, int index) {
              return Text(
                widget.num[index].toString(),
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 40,
                    color: bloc.indexOfPhoneNumber > index
                        ? MediaQuery.of(context).platformBrightness ==
                                Brightness.dark
                            ? Colors.white
                            : Colors.black
                        : Colors.grey),
              );
            },
          ),
        ),
      ],
    );
  }
}
