import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yalla_bus/core/custom_widgets/animation_widget.dart';
import 'package:yalla_bus/core/custom_widgets/text_widget.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';

class LoadingBusWidget extends StatelessWidget {
  const LoadingBusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       Lottie.asset(AssetManager.darkLoading, width: 150, height: 150),
        const SizedBox(
          height: 20,
        ),
        TextWidget(
            text: 'Retrieving Data',
            style: Theme.of(context).textTheme.headline5!),
      ],
    );
  }
}
