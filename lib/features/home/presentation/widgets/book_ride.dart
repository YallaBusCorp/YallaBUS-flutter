import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../bloc/map/map_bloc.dart';
import 'bus_times.dart';
import 'switch_button.dart';

class BookRide extends StatefulWidget {
  const BookRide({Key? key}) : super(key: key);

  @override
  State<BookRide> createState() => _BookRideState();
}

class _BookRideState extends State<BookRide> {
  bool switchColor = false;

  @override
  void didChangeDependencies() {
    BlocProvider.of<MapBloc>(context).add(GetAmAppoinmentsEvent());
    BlocProvider.of<MapBloc>(context).add(GetPmAppoinmentsEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    MapBloc bloc = BlocProvider.of<MapBloc>(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: ColorsExtensions.setColorOfContainersOverMap(context),
        borderRadius: BorderRadius.circular(ValuesManager.v16),
        boxShadow: selectShadow(context),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: ValuesManager.v16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<MapBloc, MapState>(
              builder: (context, state) {
                return Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: bloc.timeOfSelectedRides != 'Choose Ride'
                        ? () {
                            Navigator.of(context).pop();
                          }
                        : null,
                    child: TextWidget(
                      text: 'Done',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: ColorsManager.orange, fontSize: 18),
                    ),
                  ),
                );
              },
            ),
            TextWidget(
                text: 'Depart At',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontSize: 30)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                    text: 'Round-trip',
                    style: Theme.of(context).textTheme.headline6!),
                FlutterSwitch(
                  activeColor: ColorsManager.orange,
                  inactiveColor: Colors.grey,
                  width: 50,
                  height: 30,
                  value: switchColor,
                  onToggle: (e) {
                    setState(() => switchColor = !switchColor);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<MapBloc, MapState>(
              builder: (context, state) {
                return BusTimes(
                  times: bloc.amRides,
                  amOrPm: 'AM',
                );
              },
            ),
            BlocBuilder<MapBloc, MapState>(
              builder: (context, state) {
                return Visibility(
                  visible: switchColor,
                  child: BusTimes(
                    times: bloc.pmRides,
                    amOrPm: 'PM',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
