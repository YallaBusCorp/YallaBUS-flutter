import 'package:flutter/material.dart';
import 'package:yalla_bus/features/home/presentation/widgets/controllers.dart';
import 'package:yalla_bus/features/home/presentation/widgets/depart_at.dart';
import 'package:yalla_bus/features/home/presentation/widgets/from_to_widget.dart';
import 'package:yalla_bus/features/home/presentation/widgets/map.dart';

import '../widgets/ride_booked.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: const [
          MapWidget(),
          Controllers(),
          FromToWidget(),
          RideBooked(),
          DepartAt(),
        ],
      ),
    );
  }
}
