import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/custom_widgets/text_widget.dart';
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
          width: ValuesManager.v110,
          height: ValuesManager.v110,
          decoration: BoxDecoration(
            // color: ColorsManager.orange,
            borderRadius: BorderRadius.circular(ValuesManager.v100),
          ),
          child: Lottie.asset(
            AssetManager.profileAnimation,
            fit: BoxFit.cover,
            repeat: false,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: ValuesManager.v10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                  text: 'Amr Elmoogy',
                  style: Theme.of(context).textTheme.headline5!),
              const SizedBox(
                height: ValuesManager.v5,
              ),
              InkWell(
                onTap: () {},
                child: TextWidget(
                  text: 'Edit Profile',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: ValuesManager.v18, color: ColorsManager.orange),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
