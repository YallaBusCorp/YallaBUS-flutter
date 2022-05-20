import 'package:flutter/material.dart';
import 'user_statistics_single_layout.dart';

import '../../../../core/resources/asset_manager.dart';
import '../../../../core/resources/values_manager.dart';

class UserStatistics extends StatelessWidget {
  const UserStatistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: ValuesManager.v10),
      child: Row(
        children: const [
          Expanded(
            child: UserStatisticsSingleLayout(
                asset: AssetManager.meter,
                statisitcsNumber: '1901',
                description: 'Total Kilometers'),
          ),
          SizedBox(
            width: ValuesManager.v10,
          ),
          Expanded(
            child: UserStatisticsSingleLayout(
                asset: AssetManager.distance,
                statisitcsNumber: '19',
                description: 'Total Rides'),
          ),
        ],
      ),
    );
  }
}
