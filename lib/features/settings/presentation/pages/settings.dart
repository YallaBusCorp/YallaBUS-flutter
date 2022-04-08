import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:yalla_bus/core/custom_widgets/text_widget.dart';

import 'package:yalla_bus/features/settings/presentation/widgets/options.dart';
import 'package:yalla_bus/features/settings/presentation/widgets/user_statistics.dart';

import '../../../../core/resources/string_manager.dart';
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(),
            const SizedBox(
              height: 30,
            ),
            const UserStatistics(),
            const SizedBox(height: 20),
            Options(),
          ],
        ),
      ),
    );
  }
}
