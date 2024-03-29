import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../core/resources/asset_manager.dart';
import '../../../../../core/resources/colors_manager.dart';
import '../bloc/bus_ride_bloc.dart';
import '../widgets/settings.dart';
import '../widgets/unavailable_ride.dart';

import '../../../../../core/resources/constants_manager.dart';
import '../../../../../core/resources/map_manager.dart';
import '../../../../../core/resources/routes_manager.dart';
import '../../../map/presentation/bloc/bus_map_bloc.dart';
import '../../domain/entity/all_rides.dart';
import '../widgets/coming_rides.dart';

class BusRides extends StatefulWidget {
  const BusRides({Key? key}) : super(key: key);

  @override
  State<BusRides> createState() => _BusRidesState();
}

class _BusRidesState extends State<BusRides> {
  late BusRideBloc bloc;
  List<Booking> bookings = [];
  @override
  void initState() {
    bloc = BlocProvider.of<BusRideBloc>(context);
    bloc.add(CheckIfThereIsCurrentRideOrNotEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rides',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: BlocConsumer<BusRideBloc, BusRideState>(
        listener: (context, state) {
          if (state is GetListOfBooking) {
            bookings = state.bookings;
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Next Ride',
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 20),
                ),
                const SizedBox(
                  height: 5,
                ),
                bookings.isEmpty
                    ? const UnavailableRide()
                    : CurrentRides(
                        bookings: bookings,
                      ),
                const SizedBox(
                  height: 20,
                ),
                const BusSettings(),
              ],
            ),
          );
        },
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
