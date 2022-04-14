import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/resources/values_manager.dart';

class AuthHeader extends StatelessWidget {
  final String header1;
  final String header2;
  final String asset;

  const AuthHeader(
      {Key? key,
      required this.header1,
      required this.header2,
      required this.asset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                header1.tr(),
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                header2.tr(),
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
        Lottie.asset(asset,
            width: ValuesManager.v100, height: ValuesManager.v100),
      ],
    );
  }
}
