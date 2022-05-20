import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'text_widget.dart';
import '../resources/asset_manager.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(AssetManager.loading, width: 60, height: 60),
          const SizedBox(
            width: 10,
          ),
          TextWidget(
              text: 'Loading ..',
              style: Theme.of(context).textTheme.headline6!),
        ],
      ),
    );
  }
}
