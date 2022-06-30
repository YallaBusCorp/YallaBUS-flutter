import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yalla_bus/features/bus_mobile/map/presentation/bloc/bus_map_bloc.dart';
import 'package:yalla_bus/features/bus_mobile/rides/domain/entity/all_rides.dart';
import 'package:yalla_bus/features/home/presentation/widgets/controllers.dart';

import '../../../../../core/resources/asset_manager.dart';
import '../../../../../core/resources/colors_manager.dart';
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

    bloc.add(InitializeBusMarkersEvent(widget.bookings,context));
    WidgetsBinding.instance!.addObserver(this);

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
              // TODO: implement listener
            },
            builder: (context, state) {
              return GoogleMap(
                zoomControlsEnabled: false,
                markers: bloc.markers,
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
          const Controllers(),
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
