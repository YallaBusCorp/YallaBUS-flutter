import 'package:flutter/material.dart';

import '../../../domain/entity/ride_history_model.dart';
import 'ride_history_item.dart';

class MissedRideHistory extends StatelessWidget {
  final List<RideHis> list;
  const MissedRideHistory({Key? key, required this.list}) : super(key: key);

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
