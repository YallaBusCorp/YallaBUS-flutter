import 'package:flutter/material.dart';
import 'package:yalla_bus/features/settings/presentation/widgets/ride_history_item.dart';

class RidesHistory extends StatelessWidget {
  const RidesHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ride History',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: 5,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return const RideHistoryItem();
          },
        ),
      ),
    );
  }
}
