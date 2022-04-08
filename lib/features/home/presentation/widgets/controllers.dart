import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/routes_manager.dart';
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
      top: MediaQuery.of(context).size.height / 9,
      right: MediaQuery.of(context).size.width - 350,
      child: Container(
        width: 50,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ValuesManager.v16),
          color: Theme.of(context).backgroundColor,
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
                onPressed: () {
                  map.add(GetMyLocation());
                  // map.add(GetMarkers());
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
