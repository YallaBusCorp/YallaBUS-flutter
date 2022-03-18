import 'package:flutter/material.dart';
import 'package:yalla_bus/core/resources/theme_manager.dart';
import 'package:yalla_bus/features/onBoarding/pages/onBoarding_base.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: dark,
      home: const OnBoardingBase(),
    );
  }
}
