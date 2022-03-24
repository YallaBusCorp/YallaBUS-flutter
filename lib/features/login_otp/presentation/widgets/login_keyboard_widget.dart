import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_bus/core/custom_widgets/circle_widget.dart';
import 'package:yalla_bus/core/resources/string_manager.dart';
import 'package:yalla_bus/core/resources/values_manager.dart';
import 'package:yalla_bus/features/login_otp/presentation/bloc/login_bloc.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/constants_manager.dart';

class LoginKeyboardWidget extends StatelessWidget {
  const LoginKeyboardWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    LoginBloc bloc = BlocProvider.of<LoginBloc>(context);
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 2.5,
      decoration: BoxDecoration(
        color: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? ColorsManager.black2
            : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: MediaQuery.of(context).platformBrightness == Brightness.light
            ? [
                const BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                ),
              ]
            : [
                const BoxShadow(blurRadius: 0),
              ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleButtonWidget(
                  onPressed: () {
                    bloc.add(const WritePhoneNumberEvent(1));
                  },
                  child: Text(
                    ValuesManager.v1,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    bloc.add(const WritePhoneNumberEvent(2));
                  },
                  child: Text(
                    ValuesManager.v2,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    bloc.add(const WritePhoneNumberEvent(3));
                  },
                  child: Text(
                    ValuesManager.v3,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleButtonWidget(
                  onPressed: () {
                    bloc.add(const WritePhoneNumberEvent(4));
                  },
                  child: Text(
                    ValuesManager.v4,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    bloc.add(const WritePhoneNumberEvent(5));
                  },
                  child: Text(
                    ValuesManager.v5,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    bloc.add(const WritePhoneNumberEvent(6));
                  },
                  child: Text(
                    ValuesManager.v6,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleButtonWidget(
                  onPressed: () {
                    bloc.add(const WritePhoneNumberEvent(7));
                  },
                  child: Text(
                    ValuesManager.v7,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    bloc.add(const WritePhoneNumberEvent(8));
                  },
                  child: Text(
                    ValuesManager.v8,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    bloc.add(const WritePhoneNumberEvent(9));
                  },
                  child: Text(
                    ValuesManager.v9,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleButtonWidget(
                  onPressed: () {},
                  child: Text(
                    '*',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    bloc.add(const WritePhoneNumberEvent(0));
                  },
                  child: Text(
                    ValuesManager.v0,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    bloc.add(RemovePhoneNumberEvent());
                  },
                  child: Icon(Icons.backspace_outlined,
                      color: MediaQuery.of(context).platformBrightness ==
                              Brightness.dark
                          ? Colors.white
                          : Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
