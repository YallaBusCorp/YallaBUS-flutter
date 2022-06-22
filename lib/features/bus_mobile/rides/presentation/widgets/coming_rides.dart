import 'package:flutter/material.dart';
import 'package:yalla_bus/core/custom_widgets/Decoration_widget.dart';
import 'package:yalla_bus/core/custom_widgets/button_widget.dart';
import 'package:yalla_bus/core/resources/routes_manager.dart';

class CurrentRides extends StatefulWidget {
  const CurrentRides({Key? key}) : super(key: key);

  @override
  State<CurrentRides> createState() => _CurrentRidesState();
}

class _CurrentRidesState extends State<CurrentRides> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Current',
          style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 25),
        ),
        const SizedBox(height: 5,),
        DecorationBoxWidget(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Number of Students',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.grey, fontSize: 18),
                    ),
                    Text(
                      '64',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Appointment Time',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.grey, fontSize: 18),
                    ),
                    Text(
                      '08:00 Am',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ButtonWidget(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.busQrScanner);
                  },
                  width: double.infinity,
                  child: Text(
                    'Start',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
