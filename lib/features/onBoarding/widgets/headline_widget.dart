import 'package:flutter/material.dart';

import '../../../core/resources/colors_manager.dart';

import 'package:easy_localization/easy_localization.dart';

import '../../../core/resources/values_manager.dart';

class HeadlineWidget extends StatelessWidget {
  final String headline;
  const HeadlineWidget({Key? key, required this.headline}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width / ValuesManager.v3,
            color: ColorsManager.blue,
            height: ValuesManager.v2,
          ),
        ),
        const SizedBox(
          width: ValuesManager.v8,
        ),
        Expanded(
          child: Text(
            headline.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        const SizedBox(
          width: ValuesManager.v8,
        ),
        Expanded(
          child: Container(
            color: ColorsManager.green,
            height: ValuesManager.v2,
          ),
        ),
      ],
    );
  }
}
