import 'package:flutter/material.dart';
import 'package:yalla_bus/core/resources/colors_manager.dart';

class PinCode extends StatelessWidget {
  final String pin;
  const PinCode({Key? key, required this.pin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorsManager.black2,
      ),
      child: Center(
        child: Text(
          pin,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 31),
        ),
      ),
    );
  }
}
