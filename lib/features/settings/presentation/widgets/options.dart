import 'package:flutter/material.dart';
import 'package:yalla_bus/features/settings/presentation/widgets/to_screen.dart';

import '../../../../core/resources/asset_manager.dart';

class Options extends StatelessWidget {
   Options({Key? key}) : super(key: key);
   final List<String> texts = [
    'Rides history',
    'Subscription details',
    'FAQ',
    'Terms and Conditions',
    'Contact us',
    'Report a bug',
    'File a complaint',
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
      child: ListView.separated(
        itemCount: 8,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return ToScreen(asset: images[index], text: texts[index]);
        },
      ),
    );
  }
}
