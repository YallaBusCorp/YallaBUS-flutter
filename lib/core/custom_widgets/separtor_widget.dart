import 'package:flutter/material.dart';

import '../resources/values_manager.dart';

class Separtor extends StatelessWidget {
  final List<Color> color;
  const Separtor({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ValuesManager.v1,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: color),
      ),
    );
  }
}
