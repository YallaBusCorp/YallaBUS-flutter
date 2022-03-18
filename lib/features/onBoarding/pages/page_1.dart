import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/string_manager.dart';
import 'package:yalla_bus/features/onBoarding/widgets/animation_widget.dart';
import 'package:yalla_bus/features/onBoarding/widgets/descripton_widget.dart';
import 'package:yalla_bus/features/onBoarding/widgets/headline_widget.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> with TickerProviderStateMixin {
  late AnimationController _lottieController;

  @override
  void initState() {
    _lottieController = AnimationController(
      vsync: this,
      upperBound: 0.7,
      duration: const Duration(milliseconds: 500),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimationWidget(controller: _lottieController,asset: AssetManager.ticket,),
          const SizedBox(
            height: 10,
          ),
          const HeadlineWidget(headline: StringManager.easyBooking),
          const SizedBox(
            height: 10,
          ),
          const DescriptionWidget(description: StringManager.easyBookingInfo),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }
}