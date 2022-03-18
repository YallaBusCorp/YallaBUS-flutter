import 'package:flutter/material.dart';

import '../../../core/resources/string_manager.dart';

class DescriptionWidget extends StatelessWidget {
  final String description;
  const DescriptionWidget({Key? key, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: Theme.of(context).textTheme.headline6,
    );
  }
}
