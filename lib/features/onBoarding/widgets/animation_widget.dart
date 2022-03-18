import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/resources/asset_manager.dart';

class AnimationWidget extends StatefulWidget {
  String asset;
  AnimationController controller;
  AnimationWidget({Key? key, required this.controller,required this.asset}) : super(key: key);

  @override
  State<AnimationWidget> createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<AnimationWidget> {
  @override
  Widget build(BuildContext context) {
    return Lottie.asset(widget.asset,
        controller: widget.controller,
        width: MediaQuery.of(context).size.height / 3,
        height: MediaQuery.of(context).size.height / 3, onLoaded: (compostion) {
      widget.controller
        ..duration = compostion.duration
        ..forward()
        ..repeat()
        ..upperBound;
    });
  }


}
