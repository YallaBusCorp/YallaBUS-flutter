import 'package:flutter/material.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/resources/string_manager.dart';

class HeadlineWidget extends StatelessWidget {
  final String headline;
  const HeadlineWidget({Key? key,required this.headline}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 3,
          color: HexToColor.hexColor("#48B2FF"),
          height: 2,
        ),
        const SizedBox(
          width: 5,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 90,
            minHeight: 30,
            minWidth: 30,
            maxHeight: 70,
          ),
          child: Text(
            headline,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Container(
          width: MediaQuery.of(context).size.width / 3.4,
          color: HexToColor.hexColor("#59BD8F"),
          height: 2,
        ),
      ],
    );
  }
}
