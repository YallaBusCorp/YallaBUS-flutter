import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        Text('+', style: Theme.of(context).textTheme.bodyText2),
        Text('2', style: Theme.of(context).textTheme.bodyText2),
        Text('0', style: Theme.of(context).textTheme.bodyText2),
        const SizedBox(
          width: 10,
        ),
        Text('1', style: Theme.of(context).textTheme.bodyText2),
        SizedBox(
          height: 100,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.num.length,
            itemBuilder: (BuildContext context, int index) {
              return Text(
                widget.num[index].toString(),
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
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
