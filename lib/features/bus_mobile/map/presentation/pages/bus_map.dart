import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yalla_bus/core/resources/map_manager.dart';
import 'package:yalla_bus/features/bus_mobile/map/presentation/bloc/bus_map_bloc.dart';
import 'package:yalla_bus/features/bus_mobile/map/presentation/widgets/controllers.dart';
import 'package:yalla_bus/features/bus_mobile/rides/domain/entity/all_rides.dart';
import 'package:yalla_bus/features/home/presentation/bloc/map/map_bloc.dart';
import 'package:yalla_bus/features/home/presentation/widgets/controllers.dart';

import '../../../../../core/custom_widgets/error_dialog.dart';
import '../../../../../core/resources/asset_manager.dart';
import '../../../../../core/resources/colors_manager.dart';
import '../../../../../core/resources/constants_manager.dart';
import '../../../../../core/resources/routes_manager.dart';

class BusMap extends StatefulWidget {
  final List<Booking> bookings;
  const BusMap({Key? key, required this.bookings}) : super(key: key);

  @override
  State<BusMap> createState() => _BusMapState();
}

class _BusMapState extends State<BusMap> with WidgetsBindingObserver {
  late String _darkMapStyle;
  late String _lightMapStyle;
  late BusMapBloc bloc;

  @override
  void initState() {
    _loadMapStyles();
    bloc = BlocProvider.of<BusMapBloc>(context);

    bloc.add(InitializeBusMarkersEvent(widget.bookings, context));
    WidgetsBinding.instance!.addObserver(this);
    //For Simulation
    int i = -1;
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      i++;
      final data = {
        'location': FieldValue.arrayUnion([
          GeoPoint(MapManager.list[i].latitude, MapManager.list[i].longitude)
        ]),
      };
      await FirebaseFirestore.instance
          .collection('company')
          .doc(bloc.perfs.getString(ConstantsManager.companyName))
          .collection('ride')
          .doc(bloc.perfs.getString(ConstantsManager.rideID))
          .set(data, SetOptions(merge: true));
      bloc.add(RefershBusEvent(
          LatLng(MapManager.list[i].latitude, MapManager.list[i].longitude),
          context));
    });

    super.initState();
  }

  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString(AssetManager.darkMapStyle);
    _lightMapStyle = await rootBundle.loadString(AssetManager.lightMapStyle);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final GoogleMapController controller = await bloc.controller.future;
      if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
        controller.setMapStyle(_darkMapStyle);
      } else {
        controller.setMapStyle(_lightMapStyle);
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocConsumer<BusMapBloc, BusMapState>(
            listener: (context, state) {
              if (state is RideCompletedSuccess) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(Routes.busRides, (route) => false);
              }
              if (state is RideCompletedError) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      child: ErrorDialog(
                          message: state.message,
                          onTap: () {
                            bloc.add(const FinishRideEvent());
                          }),
                    );
                  },
                );
              }
            },
            builder: (context, state) {
              return GoogleMap(
                zoomControlsEnabled: false,
                markers: bloc.dropAndPick.union(bloc.markers),
                myLocationButtonEnabled: false,
                compassEnabled: false,
                mapToolbarEnabled: false,
                initialCameraPosition: bloc.kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  if (!bloc.controller.isCompleted) {
                    bloc.controller.complete(controller);
                    bloc.add(GetBusLocation(context));
                  }
                  if (MediaQuery.of(context).platformBrightness ==
                      Brightness.dark) {
                    controller.setMapStyle(_darkMapStyle);
                  } else {
                    controller.setMapStyle(_lightMapStyle);
                  }
                },
              );
            },
          ),
          const ControllersOfBus(),
        ],
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
