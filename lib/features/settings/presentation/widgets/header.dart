import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/resources/asset_manager.dart';
import '../../../../core/resources/colors_manager.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            // color: ColorsManager.orange,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Lottie.asset(
            AssetManager.profileAnimation,
            fit: BoxFit.cover,
            repeat: false,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                  text: 'Amr Elmoogy',
                  style: Theme.of(context).textTheme.headline5!),
              const SizedBox(
                height: 5,
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
        ),
      ],
    );
  }
}
