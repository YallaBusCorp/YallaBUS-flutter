import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yalla_bus/core/custom_widgets/Decoration_widget.dart';
import 'package:yalla_bus/core/custom_widgets/button_widget.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/colors_manager.dart';
import 'package:yalla_bus/features/home/presentation/widgets/book_ride.dart';
import 'package:yalla_bus/features/home/presentation/widgets/ride_booked/qr_view.dart';
import '../../../../../core/custom_widgets/loading_dialog.dart';
import '../../../../../core/custom_widgets/text_widget.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../settings/domain/entity/ride_history_model.dart';
import '../../bloc/map/map_bloc.dart';
import 'driver_info.dart';
import 'ride_option.dart';
import 'ride_info.dart';

import '../../../../../core/injection/di.dart';

class RideBooked extends StatefulWidget {
  const RideBooked({Key? key}) : super(key: key);

  @override
  State<RideBooked> createState() => _RideBookedState();
}

class _RideBookedState extends State<RideBooked> {
  late MapBloc bloc;
  RideHis ride = RideHis(-1, PickUp('name'), DropOff('name'),
      Appoint('date', 'amOrPm'), 'busId', 'emp');

  @override
  void initState() {
    bloc = BlocProvider.of<MapBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapBloc, MapState>(
      listener: (context, state) {
        if (state is StudentInCurrentRide) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          ride = state.ride;
        }
        if(state is StudentNotInCurrentRide)
        {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
        if (state is Loading) {
          showDialog(
            context: context,
            builder: (BuildContext context) => const Dialog(
              backgroundColor: Colors.transparent,
              child: LoadingDialog(),
            ),
          );
        }
      },
      builder: (context, state) {
        return ride.id != -1
            ? Visibility(
                visible: bloc.rideVisible,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: DecorationBoxWidget(
                    radius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color:
                        ColorsExtensions.setColorOfContainersOverMap(context),
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
                          DriverInfo(
                            ride: ride,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          RideOptions(
                            ride: ride,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Container();
      },
    );
  }
}
