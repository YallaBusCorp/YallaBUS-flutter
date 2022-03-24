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
      height: MediaQuery.of(context).size.height / ValuesManager.v2AndHalf,
      decoration: BoxDecoration(
        color: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? ColorsManager.black2
            : Colors.white,
        borderRadius: BorderRadius.circular(ValuesManager.v16),
        boxShadow: MediaQuery.of(context).platformBrightness == Brightness.light
            ? [
                const BoxShadow(
                  color: Colors.grey,
                  blurRadius: ValuesManager.v5,
                ),
              ]
            : [
                const BoxShadow(blurRadius: ValuesManager.v0),
              ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(ValuesManager.v16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleButtonWidget(
                  onPressed: () {
                    bloc.add(const WritePhoneNumberEvent(ValuesManager.iv1));
                  },
                  child: Text(
                    ValuesManager.iv1.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    bloc.add(const WritePhoneNumberEvent(ValuesManager.iv2));
                  },
                  child: Text(
                    ValuesManager.iv2.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    bloc.add(const WritePhoneNumberEvent(ValuesManager.iv3));
                  },
                  child: Text(
                    ValuesManager.iv3.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: ValuesManager.v10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleButtonWidget(
                  onPressed: () {
                    bloc.add(const WritePhoneNumberEvent(ValuesManager.iv4));
                  },
                  child: Text(
                    ValuesManager.iv4.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    bloc.add(const WritePhoneNumberEvent(ValuesManager.iv5));
                  },
                  child: Text(
                    ValuesManager.iv5.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    bloc.add(const WritePhoneNumberEvent(ValuesManager.iv6));
                  },
                  child: Text(
                    ValuesManager.iv6.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: ValuesManager.v10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleButtonWidget(
                  onPressed: () {
                    bloc.add(const WritePhoneNumberEvent(ValuesManager.iv7));
                  },
                  child: Text(
                    ValuesManager.iv7.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    bloc.add(const WritePhoneNumberEvent(ValuesManager.iv8));
                  },
                  child: Text(
                    ValuesManager.iv8.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    bloc.add(const WritePhoneNumberEvent(ValuesManager.iv9));
                  },
                  child: Text(
                    ValuesManager.iv9.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: ValuesManager.v10),
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
                    ValuesManager.iv0.toString(),
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
