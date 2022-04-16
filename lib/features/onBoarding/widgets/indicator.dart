import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/resources/values_manager.dart';

class Indicator extends StatelessWidget {
  final PageController controller;
  const Indicator({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: ValuesManager.iv3,
      effect: WormEffect(
        dotWidth: ValuesManager.v9,
        activeDotColor:
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Colors.white
                : Colors.black,
        dotHeight: ValuesManager.v9,
        spacing: ValuesManager.v4,
        radius: ValuesManager.v10,
        dotColor: Colors.grey,
      ),
    );
  }
}
