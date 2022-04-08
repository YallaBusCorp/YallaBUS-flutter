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
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ValuesManager.v50),
            color: ColorsManager.orange,
            boxShadow: selectShadow(context),
          ),
          child: Lottie.asset(
            AssetManager.profileAnimation,
            width: 100,
            height: 100,
            repeat: false,
          ),
        ),
        const SizedBox(
          width: 10,
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
