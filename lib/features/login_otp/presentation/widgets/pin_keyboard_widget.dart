import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_bus/core/custom_widgets/circle_widget.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';
import 'package:yalla_bus/core/resources/string_manager.dart';
import 'package:yalla_bus/core/resources/values_manager.dart';
import 'package:yalla_bus/features/login_otp/presentation/bloc/login_bloc.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/constants_manager.dart';

class PinCodeKeyboardWidget extends StatelessWidget {
  const PinCodeKeyboardWidget({Key? key}) : super(key: key);
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
                    bloc.add(const WritePinCodeEvent(ValuesManager.iv1));
                  },
                  child: Text(
                    ValuesManager.v1.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    bloc.add(const WritePinCodeEvent(ValuesManager.iv2));
                  },
                  child: Text(
                    ValuesManager.v2.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    bloc.add(const WritePinCodeEvent(ValuesManager.iv3));
                  },
                  child: Text(
                    ValuesManager.v3.toString(),
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
                    bloc.add(const WritePinCodeEvent(ValuesManager.iv4));
                  },
                  child: Text(
                    ValuesManager.v4.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    bloc.add(const WritePinCodeEvent(ValuesManager.iv5));
                  },
                  child: Text(
                    ValuesManager.v5.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    bloc.add(const WritePinCodeEvent(ValuesManager.iv6));
                  },
                  child: Text(
                    ValuesManager.v6.toString(),
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
                    bloc.add(const WritePinCodeEvent(ValuesManager.iv7));
                  },
                  child: Text(
                    ValuesManager.v7.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    bloc.add(const WritePinCodeEvent(ValuesManager.iv8));
                  },
                  child: Text(
                    ValuesManager.v8.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    bloc.add(const WritePinCodeEvent(ValuesManager.iv9));
                  },
                  child: Text(
                    ValuesManager.v9.toString(),
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
                    bloc.add(const WritePinCodeEvent(ValuesManager.iv0));
                  },
                  child: Text(
                    ValuesManager.v0.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    bloc.add(RemovePinNumberEvent());
                  },
                  child: Icon(Icons.backspace_outlined,
                      color: ColorsExtensions.isDarkOrNot(context)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
