import 'package:flutter/material.dart';

import '../../../core/resources/asset_manager.dart';
import '../../../core/resources/string_manager.dart';
import '../widgets/descripton_widget.dart';
import '../widgets/headline_widget.dart';

import '../../../core/custom_widgets/animation_widget.dart';
import '../../../core/resources/values_manager.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2>  {

 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(ValuesManager.v16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimationWidget(
            asset: AssetManager.masterCard,
            height: 3.5,
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

}
