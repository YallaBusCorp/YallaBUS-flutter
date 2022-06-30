import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/custom_widgets/Decoration_widget.dart';
import '../../../../../core/custom_widgets/separtor_widget.dart';
import '../../../../../core/resources/asset_manager.dart';
import '../../../../../core/resources/colors_manager.dart';

class BusSettings extends StatelessWidget {
  const BusSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Advanced',
          style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 20),
        ),
        const SizedBox(
          height: 5,
        ),
        DecorationBoxWidget(
          radius: BorderRadius.circular(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add fees',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: 18),
                      ),
                      SvgPicture.asset(
                        AssetManager.arrow,
                        width: 10,
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Separtor(
                color: [
                  Colors.grey.shade800,
                  Colors.grey.shade800,
                ],
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Log out',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 18, color: ColorsManager.offRed),
                      ),
                      Icon(
                        Icons.delete,
                        size: 20,
                        color: ColorsManager.offRed,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
