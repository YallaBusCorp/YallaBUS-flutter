import 'package:flutter/material.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/resources/colors_manager.dart';
import '../../../core/resources/string_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class HeadlineWidget extends StatelessWidget {
  final String headline;
  const HeadlineWidget({Key? key, required this.headline}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 3,
          color: ColorsManager.blue,
          height: 2,
        ),
        const SizedBox(
          width: 8,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 90,
            minHeight: 30,
            minWidth: 30,
            maxHeight: 70,
          ),
          child: Text(
            headline.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Container(
            color: ColorsManager.green,
            height: 2,
          ),
        ),
      ],
    );
  }
}
