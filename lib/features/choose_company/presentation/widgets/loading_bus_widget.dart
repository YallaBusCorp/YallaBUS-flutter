import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/resources/asset_manager.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/values_manager.dart';

class LoadingBusWidget extends StatelessWidget {
  const LoadingBusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(AssetManager.darkLoading,
            width: ValuesManager.v150, height: ValuesManager.v150),
        const SizedBox(
          height: ValuesManager.v20,
        ),
        TextWidget(
            text: StringManager.retrivingData,
            style: Theme.of(context).textTheme.headline5!),
      ],
    );
  }
}
