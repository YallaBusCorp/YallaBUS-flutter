// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationWidget extends StatefulWidget {
  String asset;
  double width;
  double height;
  AnimationWidget(
      {Key? key,
      required this.asset,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  State<AnimationWidget> createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<AnimationWidget> {
  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      widget.asset,
      width: MediaQuery.of(context).size.height / widget.width,
      height: MediaQuery.of(context).size.height / widget.height,
      frameRate: FrameRate.max,
    );
  }
}
