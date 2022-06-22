import 'package:flutter/material.dart';
import 'package:yalla_bus/features/settings/presentation/widgets/ride_history/ride_history_item.dart';

import '../../../domain/entity/ride_history_model.dart';

class DoneRideHistory extends StatelessWidget {
  final List<RideHis> list;
  const DoneRideHistory({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: list.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return RideHistoryItem(
            rideHis: list[index],
          );
        },
      ),
    );
  }
}
