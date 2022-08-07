import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/constants_manager.dart';
import '../../../../core/resources/map_manager.dart';
import '../bloc/map/map_bloc.dart';
import '../bloc/ride_booked/ride_booked_bloc.dart';
import '../bloc/ride_booking/ride_booking_bloc.dart';
import '../widgets/controllers.dart';
import '../widgets/depart_at.dart';
import '../widgets/from_to_widget.dart';
import '../widgets/map.dart';
import '../widgets/ride_booked/ride_booked.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late MapBloc _mapBloc;
  late RideBookedBloc _rideBookedBloc;
  late RideBookingBloc _rideBookingBloc;
  @override
  void initState() {
    _mapBloc = BlocProvider.of<MapBloc>(context);
    MapManager.location.onLocationChanged.listen((newLocation) {
      _mapBloc.add(RefreshMyLocationChanagesEvent(newLocation));
    });
    _rideBookedBloc = BlocProvider.of<RideBookedBloc>(context);
    _rideBookedBloc.add(GetCurrentRideByUIDEvent(
        _rideBookedBloc.perfs.getString(ConstantsManager.uid)!, context));
    _rideBookedBloc.add(FormToPreparationEvent());
    _rideBookingBloc.add(GetStudentIDEvent(
        _rideBookingBloc.perfs.getString(ConstantsManager.uid)!));

    super.initState();
  }

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
