import 'package:flutter/material.dart';

class CircleButtonWidget extends StatelessWidget {
  final GestureTapCallback onPressed;
  final Widget child;
  const CircleButtonWidget(
      {Key? key, required this.onPressed, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: const Size(60, 60),
        primary: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
