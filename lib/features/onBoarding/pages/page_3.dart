import 'package:flutter/material.dart';

import '../../../core/custom_widgets/animation_widget.dart';
import '../../../core/resources/asset_manager.dart';
import '../../../core/resources/string_manager.dart';
import '../../../core/resources/values_manager.dart';
import '../widgets/descripton_widget.dart';
import '../widgets/headline_widget.dart';

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(ValuesManager.v16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimationWidget(
            asset: AssetManager.liveTracking,
            width: ValuesManager.v3,
            height: ValuesManager.v3,
          ),
          const SizedBox(
            height: ValuesManager.v10,
          ),
          const HeadlineWidget(headline: StringManager.liveTracking),
          const SizedBox(
            height: ValuesManager.v10,
          ),
          const DescriptionWidget(description: StringManager.liveTrackingInfo),
        ],
      ),
    );
  }
}
