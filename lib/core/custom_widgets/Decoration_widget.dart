import 'package:flutter/material.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';
import 'package:yalla_bus/core/resources/values_manager.dart';

class DecorationBoxWidget extends StatelessWidget {
  final Widget child;
  final Color? color;
  const DecorationBoxWidget({Key? key, required this.child, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).backgroundColor,
        boxShadow: selectShadow(context),
        borderRadius: BorderRadius.circular(ValuesManager.v16),
      ),
      child: child,
    );
  }
}
