import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_bus/features/home/presentation/bloc/map/map_bloc.dart';
import 'package:yalla_bus/features/settings/domain/entity/ride_history_model.dart';
import '../../../../../core/custom_widgets/Decoration_widget.dart';
import '../../../../../core/custom_widgets/text_widget.dart';

class DriverInfo extends StatefulWidget {
  final RideHis ride;
  const DriverInfo({Key? key, required this.ride}) : super(key: key);

  @override
  State<DriverInfo> createState() => _DriverInfoState();
}

class _DriverInfoState extends State<DriverInfo> {
  late MapBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<MapBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: bloc.markersOfBus.isEmpty,
                  child: Text(
                    'Ride has not started yet',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                Visibility(
                  visible: bloc.markersOfBus.isNotEmpty,
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
                  visible: bloc.markersOfBus.isNotEmpty,
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
            const SizedBox(
              width: 45,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: [
                TextWidget(
                  text: '${bloc.distanceOfRide.toInt()}',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontSize: 30),
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
