import 'package:flutter/material.dart';
import '../../../../core/extensions/extensions.dart';
import 'settings_item.dart';

import '../../../../core/resources/asset_manager.dart';
import '../../../../core/resources/values_manager.dart';

class Options extends StatelessWidget {
  Options({Key? key}) : super(key: key);
  final List<String> texts = [
    'Rides history',
    'Subscription details',
    'FAQ',
    'Terms and Conditions',
    'Contact us',
    'Report a problem',
    'Complaints',
    'Fill Exam Schedule',
  ];
  final List<String> images = [
    AssetManager.distance,
    AssetManager.subscription,
    AssetManager.fag,
    AssetManager.termsConditions,
    AssetManager.contactUs,
    AssetManager.reportBug,
    AssetManager.fileComplaint,
    AssetManager.newExam,
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ValuesManager.v10),
          boxShadow: selectShadow(context),
          color: Theme.of(context).backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.separated(
            itemCount: ValuesManager.iv8,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: ValuesManager.v15,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return ToScreen(
                asset: images[index],
                text: texts[index],
                index: index,
              );
            },
          ),
        ),
      ),
    );
  }
}
