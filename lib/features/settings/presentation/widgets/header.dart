import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/resources/asset_manager.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/values_manager.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Positioned(
          top: 2,
          left: 60,
          child: Lottie.asset(
            AssetManager.profileAnimation,
            width: 150,
            height: 150,
            repeat: false,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
                text: 'Amr Elmoogy',
                style: Theme.of(context).textTheme.headline5!),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {},
              child: TextWidget(
                text: 'Edit Profile',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: 18, color: ColorsManager.orange),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
