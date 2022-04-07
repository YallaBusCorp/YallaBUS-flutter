import 'package:flutter/material.dart';
import 'package:yalla_bus/core/resources/colors_manager.dart';

class Painting extends StatelessWidget {
  const Painting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 5,
          backgroundColor: ColorsManager.green,
        ),
        Container(
          width: 1,
          height: 35,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorsManager.green,
                ColorsManager.blue2,
              ],
            ),
          ),
        ),
        CircleAvatar(
          radius: 5,
          backgroundColor: ColorsManager.blue2,
        ),
      ],
    );
  }
}