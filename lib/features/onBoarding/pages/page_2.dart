import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/string_manager.dart';
import 'package:yalla_bus/features/onBoarding/widgets/descripton_widget.dart';
import 'package:yalla_bus/features/onBoarding/widgets/headline_widget.dart';

import '../../../core/custom_widgets/animation_widget.dart';
import '../../../core/resources/values_manager.dart';

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
      duration: Duration(milliseconds: ValuesManager.v500.toInt()),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(ValuesManager.v16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimationWidget(
            controller: _lottieController,
            asset: AssetManager.masterCard,
            height: ValuesManager.v3,
            width: ValuesManager.v3,
          ),
          const SizedBox(
            height: ValuesManager.v10,
          ),
          const HeadlineWidget(headline: StringManager.securePayment),
          const SizedBox(
            height: ValuesManager.v10,
          ),
          const DescriptionWidget(description: StringManager.securePaymentInfo),
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
