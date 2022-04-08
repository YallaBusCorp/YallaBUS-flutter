import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yalla_bus/core/resources/routes_manager.dart';

import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/resources/string_manager.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.successfulPayment, (route) => false);
            },
            icon: const Icon(
              Icons.done,
            ),
          ),
        ],
        title: TextWidget(
            text: StringManager.compeletProfile.tr(),
            style: Theme.of(context).textTheme.headline5!),
      ),
      body: Center(
        child: TextWidget(
            text: 'Web View', style: Theme.of(context).textTheme.headline5!),
      ),
    );
  }
}
