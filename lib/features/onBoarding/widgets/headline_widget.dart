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
        Container(
          width: MediaQuery.of(context).size.width / ValuesManager.v3,
          color: ColorsManager.blue,
          height: ValuesManager.v2,
        ),
        const SizedBox(
          width: ValuesManager.v8,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: ValuesManager.v100,
            minHeight: ValuesManager.v30,
            minWidth: ValuesManager.v30,
            maxHeight: ValuesManager.v70,
          ),
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
