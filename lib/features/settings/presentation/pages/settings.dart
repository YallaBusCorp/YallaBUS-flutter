import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:yalla_bus/core/custom_widgets/text_widget.dart';

import 'package:yalla_bus/features/settings/presentation/widgets/options.dart';
import 'package:yalla_bus/features/settings/presentation/widgets/user_statistics.dart';

import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../widgets/header.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
            text: StringManager.settings.tr(),
            style: Theme.of(context).textTheme.headline5!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(ValuesManager.v16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(),
            const UserStatistics(),
            const SizedBox(height: ValuesManager.v20),
            Options(),
          ],
        ),
      ),
    );
  }
}
