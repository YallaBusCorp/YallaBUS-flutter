import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_bus/core/resources/map_manager.dart';
import 'package:yalla_bus/features/home/presentation/bloc/map/map_bloc.dart';
import '../../../../core/resources/constants_manager.dart';
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
  late MapBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<MapBloc>(context);

    bloc.add(GetCurrentRideByUIDEvent(
        bloc.perfs.getString(ConstantsManager.uid)!, context));

    // MapManager.location.onLocationChanged.listen((newLocation) {
    //   bloc.add(RefreshMyLocationChanagesEvent(newLocation));
    // });
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
