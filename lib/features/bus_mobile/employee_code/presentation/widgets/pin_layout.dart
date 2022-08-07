import 'package:flutter/material.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/resources/values_manager.dart';

class PinLayout extends StatefulWidget {
  final String pin;
  const PinLayout({Key? key, required this.pin}) : super(key: key);

  @override
  State<PinLayout> createState() => _PinLayoutState();
}

class _PinLayoutState extends State<PinLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ValuesManager.v45,
      height: ValuesManager.v55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ValuesManager.v8),
        color: ColorsExtensions.setColorOfPin(context),
      ),
      child: Center(
        child: Text(
          widget.pin,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }
}
