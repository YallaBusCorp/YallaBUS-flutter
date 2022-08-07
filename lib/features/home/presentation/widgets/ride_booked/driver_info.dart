import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/enitity/returned_ride.dart';
import '../../bloc/map/map_bloc.dart';
import 'ride_booked.dart';
import '../../../../settings/domain/entity/ride_history_model.dart';
import '../../../../../core/custom_widgets/Decoration_widget.dart';
import '../../../../../core/custom_widgets/text_widget.dart';
import '../../../../../core/resources/map_manager.dart';
import '../../bloc/ride_booked/ride_booked_bloc.dart';
import '../../bloc/ride_booking/ride_booking_bloc.dart';

class DriverInfo extends StatefulWidget {
  final RideHis ride;
  const DriverInfo({Key? key, required this.ride}) : super(key: key);

  @override
  State<DriverInfo> createState() => _DriverInfoState();
}

class _DriverInfoState extends State<DriverInfo> {
  late RideBookedBloc _bloc;
  late RideBookingBloc _rideBookingBloc;
  @override
  void initState() {
    _bloc = BlocProvider.of<RideBookedBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: !_bloc.value,
                    child: Text(
                      'Ride has not started yet',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  Visibility(
                    visible: _bloc.value,
                    child: Text(
                      widget.ride.emp!.empName,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Visibility(
                    visible: _bloc.value,
                    child: DecorationBoxWidget(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.ride.bus!.busLicenceNumber,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MapManager.markersOfBus.isEmpty
                  ? MediaQuery.of(context).size.width / 8
                  : MediaQuery.of(context).size.width / 4.5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: [
                TextWidget(
                  text: '${_rideBookingBloc.distanceOfRide.toInt()}',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontSize: 25),
                ),
                TextWidget(
                  text: 'Km',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontSize: 18),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
