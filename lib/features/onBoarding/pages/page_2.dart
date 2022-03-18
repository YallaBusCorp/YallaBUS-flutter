import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/string_manager.dart';
import 'package:yalla_bus/features/onBoarding/widgets/animation_widget.dart';
import 'package:yalla_bus/features/onBoarding/widgets/descripton_widget.dart';
import 'package:yalla_bus/features/onBoarding/widgets/headline_widget.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> with TickerProviderStateMixin {
  late AnimationController _lottieController;
  @override
  void initState() {
    _lottieController = AnimationController(
      vsync: this,
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
         AnimationWidget(controller: _lottieController,asset: AssetManager.masterCard,),
          const SizedBox(
            height: 10,
          ),
          const HeadlineWidget(headline: StringManager.securePayment),
          const SizedBox(
            height: 10,
          ),
          const DescriptionWidget(description: StringManager.lorem),
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
