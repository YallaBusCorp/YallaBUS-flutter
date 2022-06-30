import 'package:flutter/material.dart';
import 'package:yalla_bus/core/custom_widgets/Decoration_widget.dart';
import 'package:yalla_bus/core/custom_widgets/button_widget.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';
import 'package:yalla_bus/core/resources/routes_manager.dart';

import '../../domain/entity/all_rides.dart';

class CurrentRides extends StatefulWidget {
  final List<Booking> bookings;
  const CurrentRides({Key? key, required this.bookings}) : super(key: key);

  @override
  State<CurrentRides> createState() => _CurrentRidesState();
}

class _CurrentRidesState extends State<CurrentRides> {
  late String time;
  @override
  void initState() {
    time = StringsExtensions.convertHourTo12HoursOnly(
        widget.bookings.first.appoinment.appointmentStartTime);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
                      widget.bookings.length.toString(),
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
                      time,
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
                    Navigator.of(context)
                        .pushNamed(Routes.busMap, arguments: widget.bookings);
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
