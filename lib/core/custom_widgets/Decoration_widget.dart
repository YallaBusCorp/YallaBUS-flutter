import 'package:flutter/material.dart';
import '../extensions/extensions.dart';
import '../resources/values_manager.dart';

class DecorationBoxWidget extends StatelessWidget {
  final Widget child;
  final Color? color;
  final BorderRadius? radius;
  const DecorationBoxWidget(
      {Key? key, required this.child, this.color, this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).backgroundColor,
        
        borderRadius: radius ?? BorderRadius.circular(ValuesManager.v16),
      ),
      child: child,
    );
  }
}
