import 'package:flutter/material.dart';
import 'package:yalla_bus/core/resources/colors_manager.dart';

import '../../../../../core/custom_widgets/Decoration_widget.dart';

class UnavailableRide extends StatefulWidget {
  const UnavailableRide({Key? key}) : super(key: key);

  @override
  State<UnavailableRide> createState() => _UnavailableRideState();
}

class _UnavailableRideState extends State<UnavailableRide> {
  @override
  Widget build(BuildContext context) {
    return DecorationBoxWidget(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'There is not ride yet!',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.grey, fontSize: 18),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Refersh',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: ColorsManager.orange, fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
