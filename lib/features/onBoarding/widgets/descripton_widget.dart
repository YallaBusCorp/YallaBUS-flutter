import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

class DescriptionWidget extends StatelessWidget {
  final String description;
  const DescriptionWidget({Key? key, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      description.tr(),
      style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 16),
    );
  }
}
