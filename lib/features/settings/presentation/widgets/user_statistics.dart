import 'package:flutter/material.dart';
import 'package:yalla_bus/features/settings/presentation/widgets/user_statistics_single_layout.dart';

import '../../../../core/resources/asset_manager.dart';


class UserStatistics extends StatelessWidget {
  const UserStatistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: UserStatisticsSingleLayout(
              asset: AssetManager.meter,
              statisitcsNumber: '1901',
              description: 'Total Kilometers'),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: UserStatisticsSingleLayout(
              asset: AssetManager.distance,
              statisitcsNumber: '19',
              description: 'Total Rides'),
        ),
      ],
    );
  }
}
