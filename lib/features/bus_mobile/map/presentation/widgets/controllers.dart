import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yalla_bus/features/bus_mobile/map/presentation/bloc/bus_map_bloc.dart';

import '../../../../../core/custom_widgets/separtor_widget.dart';
import '../../../../../core/custom_widgets/yes_no_dialog.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/resources/values_manager.dart';

class ControllersOfBus extends StatefulWidget {
  const ControllersOfBus({Key? key}) : super(key: key);

  @override
  State<ControllersOfBus> createState() => _ControllersOfBusState();
}

class _ControllersOfBusState extends State<ControllersOfBus> {
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
      right: 12,
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
                  Icons.add,
                  color: Theme.of(context).iconTheme.color,
                  size: Theme.of(context).iconTheme.size,
                ),
              ),
              const Separtor(
                color: [Colors.grey, Colors.grey],
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return Dialog(
                          insetPadding: const EdgeInsets.all(16),
                          backgroundColor: Colors.transparent,
                          child: YesNoDialog(
                              message:
                                  'Are you sure you want to finish this ride?',
                              labelTap1: 'Yes',
                              labelTap2: 'No',
                              onTap: () {
                                map.add(const FinishRideEvent());
                                Navigator.of(context).pop();
                              }),
                        );
                      });
                },
                icon: Icon(
                  Icons.pause,
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
