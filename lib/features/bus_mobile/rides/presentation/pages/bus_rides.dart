import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/colors_manager.dart';
import 'package:yalla_bus/features/bus_mobile/rides/presentation/widgets/settings.dart';

import '../../../../../core/resources/routes_manager.dart';
import '../widgets/coming_rides.dart';

class BusRides extends StatefulWidget {
  const BusRides({Key? key}) : super(key: key);

  @override
  State<BusRides> createState() => _BusRidesState();
}

class _BusRidesState extends State<BusRides> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rides',
          style: Theme.of(context).textTheme.headline5,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              size: 30,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            CurrentRides(),
            SizedBox(
              height: 20,
            ),
            BusSettings(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.busQrScanner);
        },
        child: SvgPicture.asset(
          AssetManager.scan,
          width: 30,
          height: 30,
          color: Colors.white,
        ),
        backgroundColor: ColorsManager.orange,
      ),
    );
  }
}
