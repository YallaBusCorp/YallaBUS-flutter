import 'package:flutter/material.dart';
import 'package:yalla_bus/core/resources/constants.dart';

class ButtonWidget extends StatelessWidget {
  final Function func;
  final Widget child;
  const ButtonWidget({Key? key, required this.func, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        func;
      },
      child: child,
      style: Theme.of(context).elevatedButtonTheme.style,
    );
  }
}
