import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yalla_bus/features/home/presentation/bloc/map/map_bloc.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/resources/asset_manager.dart';
import '../../../../core/resources/values_manager.dart';

class StaticMap extends StatefulWidget {
  const StaticMap({Key? key}) : super(key: key);

  @override
  State<StaticMap> createState() => _StaticMapState();
}

class _StaticMapState extends State<StaticMap> {
  late String _darkMapStyle;

  @override
  void initState() {
    _loadMapStyles();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    BlocProvider.of<MapBloc>(context).add(InitializeStaticMapEvent());
    super.didChangeDependencies();
  }

  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString(AssetManager.darkMapStyle);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return SizedBox(
          height: ValuesManager.v150,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(ValuesManager.v16),
              boxShadow: selectShadow(context),
            ),
            child: GoogleMap(
              scrollGesturesEnabled: false,
              rotateGesturesEnabled: false,
              zoomGesturesEnabled: false,
              zoomControlsEnabled: false,
              markers: BlocProvider.of<MapBloc>(context).markers2,
              initialCameraPosition:
                  BlocProvider.of<MapBloc>(context).kGooglePlex2,
              onMapCreated: (GoogleMapController controller) {
                if (MediaQuery.of(context).platformBrightness ==
                    Brightness.dark) {
                  controller.setMapStyle(_darkMapStyle);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
