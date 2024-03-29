// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../resources/colors_manager.dart';

class ButtonWidget extends StatelessWidget {
  final GestureTapCallback? onPressed;
  final Widget child;
  final Color? color;
  double? width;
  double? height;
  ButtonWidget(
      {Key? key,
      required this.onPressed,
      required this.child,
      this.color,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ElevatedButton.styleFrom(
        minimumSize:
            Size(width ?? MediaQuery.of(context).size.width - 50, height ?? 50),
        primary: color ?? ColorsManager.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
