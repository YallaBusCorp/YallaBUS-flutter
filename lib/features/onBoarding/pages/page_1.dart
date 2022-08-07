import 'package:flutter/material.dart';

import '../../../core/custom_widgets/animation_widget.dart';
import '../../../core/resources/asset_manager.dart';
import '../../../core/resources/string_manager.dart';
import '../../../core/resources/values_manager.dart';
import '../widgets/descripton_widget.dart';
import '../widgets/headline_widget.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(ValuesManager.v16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimationWidget(
              asset: AssetManager.ticket, width: ValuesManager.v3, height: 3.5),
          const SizedBox(
            height: ValuesManager.v10,
          ),
          const HeadlineWidget(headline: StringManager.easyBooking),
          const SizedBox(
            height: ValuesManager.v10,
          ),
          const DescriptionWidget(description: StringManager.easyBookingInfo),
        ],
      ),
    );
  }
}
