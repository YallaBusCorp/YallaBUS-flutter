import 'package:flutter/material.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/values_manager.dart';

class Painting extends StatelessWidget {
  const Painting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: ValuesManager.v5,
          backgroundColor: ColorsManager.green,
        ),
        Container(
          width: ValuesManager.v3,
          height: ValuesManager.v35,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorsManager.green,
                ColorsManager.blue2,
              ],
            ),
          ),
        ),
        CircleAvatar(
          radius: ValuesManager.v5,
          backgroundColor: ColorsManager.blue2,
        ),
      ],
    );
  }
}
