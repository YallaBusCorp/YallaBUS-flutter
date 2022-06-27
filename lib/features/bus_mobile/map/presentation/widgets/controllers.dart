import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_bus/features/bus_mobile/map/presentation/bloc/bus_map_bloc.dart';

import '../../../../../core/custom_widgets/separtor_widget.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/resources/values_manager.dart';

class Controllers extends StatefulWidget {
  const Controllers({Key? key}) : super(key: key);

  @override
  State<Controllers> createState() => _ControllersState();
}

class _ControllersState extends State<Controllers> {
  late BusMapBloc map;
  @override
  void initState() {
    map = BlocProvider.of<BusMapBloc>(context);

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
                  // Navigator.of(context).pushNamed(Routes.settings);
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
                onPressed: () {
                  // map.add(GetMyLocation());
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
