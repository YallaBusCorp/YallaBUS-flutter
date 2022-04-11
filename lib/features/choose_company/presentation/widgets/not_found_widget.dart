import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yalla_bus/core/custom_widgets/text_widget.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(AssetManager.error404,
            width: MediaQuery.of(context).size.width - 100,
            height: MediaQuery.of(context).size.width - 100),
        const SizedBox(
          height: 10,
        ),
        TextWidget(
            text: 'Not found!', style: Theme.of(context).textTheme.headline5!),
      ],
    );
  }
}
