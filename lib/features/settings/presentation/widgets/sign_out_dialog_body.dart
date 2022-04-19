import 'package:flutter/material.dart';
import 'package:yalla_bus/core/custom_widgets/text_widget.dart';

class SignOutDialogBody extends StatelessWidget {
  const SignOutDialogBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextWidget(
            text: 'Are you sure you want to sign out ?',
            style: Theme.of(context).textTheme.headline6!),
      ],
    );
  }
}
