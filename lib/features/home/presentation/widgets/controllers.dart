import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_bus/features/home/presentation/bloc/map_bloc.dart';
import 'package:yalla_bus/features/home/presentation/widgets/map.dart';

import '../../../../core/custom_widgets/separtor_widget.dart';

import '../../../../core/resources/values_manager.dart';

class Controllers extends StatelessWidget {
  const Controllers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MapBloc map = BlocProvider.of<MapBloc>(context);
    return Positioned(
      top: MediaQuery.of(context).size.height / 3,
      right: MediaQuery.of(context).size.width - 20,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ValuesManager.v16),
          color: Theme.of(context).backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(ValuesManager.v8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.settings,
                  color: Theme.of(context).backgroundColor,
                ),
              ),
              const Separtor(
                color: [Colors.grey],
              ),
              IconButton(
                onPressed: () {
                  map.add(GetMyLocation());
                },
                icon: Icon(
                  Icons.gps_fixed,
                  color: Theme.of(context).backgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
