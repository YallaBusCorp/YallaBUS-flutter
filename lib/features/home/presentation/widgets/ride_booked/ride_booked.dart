import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yalla_bus/core/custom_widgets/Decoration_widget.dart';
import 'package:yalla_bus/core/custom_widgets/button_widget.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/colors_manager.dart';
import 'package:yalla_bus/features/home/presentation/widgets/book_ride.dart';
import 'package:yalla_bus/features/home/presentation/widgets/ride_booked/qr_view.dart';
import '../../../../../core/custom_widgets/text_widget.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../bloc/map/map_bloc.dart';
import 'driver_info.dart';
import 'ride_option.dart';
import 'ride_info.dart';

import '../../../../../core/injection/di.dart';

class RideBooked extends StatelessWidget {
  const RideBooked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: false,
      child: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: DecorationBoxWidget(
              radius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: ColorsExtensions.setColorOfContainersOverMap(context),
              child: Padding(
                padding: const EdgeInsets.all(ValuesManager.v16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your driver is comming',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: 18),
                    ),
                    const DriverInfo(),
                    const SizedBox(
                      height: 15,
                    ),
                    const RideOptions(),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
