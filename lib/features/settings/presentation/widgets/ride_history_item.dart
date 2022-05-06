import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yalla_bus/core/custom_widgets/Decoration_widget.dart';
import 'package:yalla_bus/core/custom_widgets/text_widget.dart';

import 'package:yalla_bus/features/settings/presentation/widgets/From_to_body.dart';
import 'package:yalla_bus/features/settings/presentation/widgets/bus_ride_info.dart';
import '../../../../core/resources/colors_manager.dart';

class RideHistoryItem extends StatelessWidget {
  const RideHistoryItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecorationBoxWidget(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                    text: '08:20 AM 12 March',
                    style: Theme.of(context).textTheme.caption!),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.warning_rounded),
                  iconSize: 30,
                  color: ColorsManager.orange,
                )
              ],
            ),
            const FromToBody(),
            const SizedBox(
              height: 10,
            ),
            const BusRideInfo(),
          ],
        ),
      ),
    );
  }
}
