import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/injection/di.dart';
import '../../../../core/resources/constants_manager.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../sign_up/domain/use_case/get_student_id.dart';
import '../bloc/map/map_bloc.dart';

import '../../../../core/custom_widgets/separtor_widget.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/resources/values_manager.dart';

class Controllers extends StatefulWidget {
  const Controllers({Key? key}) : super(key: key);

  @override
  State<Controllers> createState() => _ControllersState();
}

class _ControllersState extends State<Controllers> {
  late MapBloc map;
  late GoogleMapPolyline googleMapPolyline;
  @override
  void initState() {
    map = BlocProvider.of<MapBloc>(context);
    googleMapPolyline = GoogleMapPolyline(apiKey: ConstantsManager.mapToken);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height - 180,
      right: MediaQuery.of(context).size.width - ValuesManager.v350,
      child: Container(
        width: ValuesManager.v50,
        height: ValuesManager.v100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ValuesManager.v10),
          color: ColorsExtensions.setColorOfContainersOverMap(context),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.settings);
                },
                icon: Icon(
                  Icons.settings,
                  color: Theme.of(context).iconTheme.color,
                  size: Theme.of(context).iconTheme.size,
                ),
              ),
              const Separtor(
                color: [Colors.grey, Colors.grey],
              ),
              IconButton(
                onPressed: () async {
                  // map.add(GetMyLocation());
                  List<LatLng>? coordinates =
                      await googleMapPolyline.getCoordinatesWithLocation(
                          origin: const LatLng(
                              30.739511310446257, 31.263069637010513),
                          destination: const LatLng(30.773347, 31.259078),
                          mode: RouteMode.driving);
                  int i = 0;
                  Timer.periodic(const Duration(milliseconds: 500), (timer) {
                    map.add(RefreshBusCoordinateEvent(coordinates![i]));
                    i++;
                  });
                },
                icon: Icon(
                  Icons.gps_fixed,
                  color: Theme.of(context).iconTheme.color,
                  size: Theme.of(context).iconTheme.size,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
