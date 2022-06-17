import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/custom_widgets/circle_widget.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../bloc/Keyboard/keyboard_bloc.dart';


class KeyboardWidget extends StatelessWidget {
  final String type;
  const KeyboardWidget({
    required this.type,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    KeyboardBloc bloc = BlocProvider.of<KeyboardBloc>(context);
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / ValuesManager.v2AndHalf,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(ValuesManager.v16),
 
      ),
      child: Padding(
        padding: const EdgeInsets.all(ValuesManager.v16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleButtonWidget(
                  onPressed: () {
                    type == StringManager.otp
                        ? bloc.add(const WritePinCodeEvent(ValuesManager.iv1))
                        : bloc.add(
                            const WritePhoneNumberEvent(ValuesManager.iv1));
                  },
                  child: Text(
                    ValuesManager.iv1.toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    type == StringManager.otp
                        ? bloc.add(const WritePinCodeEvent(ValuesManager.iv2))
                        : bloc.add(
                            const WritePhoneNumberEvent(ValuesManager.iv2));
                  },
                  child: Text(
                    ValuesManager.iv2.toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    type == StringManager.otp
                        ? bloc.add(const WritePinCodeEvent(ValuesManager.iv3))
                        : bloc.add(
                            const WritePhoneNumberEvent(ValuesManager.iv3));
                  },
                  child: Text(
                    ValuesManager.iv3.toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
            const SizedBox(height: ValuesManager.v10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleButtonWidget(
                  onPressed: () {
                    type == StringManager.otp
                        ? bloc.add(const WritePinCodeEvent(ValuesManager.iv4))
                        : bloc.add(
                            const WritePhoneNumberEvent(ValuesManager.iv4));
                  },
                  child: Text(
                    ValuesManager.iv4.toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    type == StringManager.otp
                        ? bloc.add(const WritePinCodeEvent(ValuesManager.iv5))
                        : bloc.add(
                            const WritePhoneNumberEvent(ValuesManager.iv5));
                  },
                  child: Text(
                    ValuesManager.iv5.toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    type == StringManager.otp
                        ? bloc.add(const WritePinCodeEvent(ValuesManager.iv6))
                        : bloc.add(
                            const WritePhoneNumberEvent(ValuesManager.iv6));
                  },
                  child: Text(
                    ValuesManager.iv6.toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
            const SizedBox(height: ValuesManager.v10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleButtonWidget(
                  onPressed: () {
                    type == StringManager.otp
                        ? bloc.add(const WritePinCodeEvent(ValuesManager.iv7))
                        : bloc.add(
                            const WritePhoneNumberEvent(ValuesManager.iv7));
                  },
                  child: Text(
                    ValuesManager.iv7.toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    type == StringManager.otp
                        ? bloc.add(const WritePinCodeEvent(ValuesManager.iv8))
                        : bloc.add(
                            const WritePhoneNumberEvent(ValuesManager.iv8));
                  },
                  child: Text(
                    ValuesManager.iv8.toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    type == StringManager.otp
                        ? bloc.add(const WritePinCodeEvent(ValuesManager.iv9))
                        : bloc.add(
                            const WritePhoneNumberEvent(ValuesManager.iv9));
                  },
                  child: Text(
                    ValuesManager.iv9.toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
            const SizedBox(height: ValuesManager.v10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //new edit
                SizedBox(
                  width: MediaQuery.of(context).size.width / 6,
                ),
                CircleButtonWidget(
                  onPressed: () {
                    type == StringManager.otp
                        ? bloc.add(const WritePinCodeEvent(ValuesManager.iv0))
                        : bloc.add(
                            const WritePhoneNumberEvent(ValuesManager.iv0));
                  },
                  child: Text(
                    ValuesManager.iv0.toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                CircleButtonWidget(
                  onPressed: () {
                    type == StringManager.otp
                        ? bloc.add(RemovePinNumberEvent())
                        : bloc.add(RemovePhoneNumberEvent());
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
