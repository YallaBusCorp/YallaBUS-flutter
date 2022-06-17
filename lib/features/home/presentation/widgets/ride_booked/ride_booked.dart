import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../bloc/map/map_bloc.dart';
import 'driver_info.dart';
import 'ride_controllers.dart';
import 'ride_info.dart';

import '../../../../../core/injection/di.dart';

class RideBooked extends StatelessWidget {
  const RideBooked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MapBloc bloc = di<MapBloc>();
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return Visibility(
          visible: bloc.perfs.getBool('Booked') ?? true,
          child: Positioned(
            bottom: MediaQuery.of(context).size.height - 720,
            child: Container(
              width: MediaQuery.of(context).size.width - ValuesManager.v20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ValuesManager.v16),
                
                color: ColorsExtensions.setColorOfContainersOverMap(context),
              ),
              child: Padding(
                padding: const EdgeInsets.all(ValuesManager.v16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    DriverInfo(),
                    SizedBox(
                      height: 10,
                    ),
                    RideInfo(),
                    SizedBox(
                      height: 10,
                    ),
                    RideControllers(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
