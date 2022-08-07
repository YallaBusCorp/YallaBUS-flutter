import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../../../core/resources/constants_manager.dart';
import '../../domain/enitity/reschedule_body.dart';
import '../../../settings/domain/entity/ride_history_model.dart';
import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../domain/enitity/returned_ride.dart';
import '../../domain/enitity/ride.dart';
import '../bloc/map/map_bloc.dart';
import '../bloc/ride_booked/ride_booked_bloc.dart';
import '../bloc/ride_booking/ride_booking_bloc.dart';
import 'bus_times.dart';

class BookRideScreen extends StatefulWidget {
  const BookRideScreen({Key? key}) : super(key: key);

  @override
  State<BookRideScreen> createState() => _BookRideScreenState();
}

class _BookRideScreenState extends State<BookRideScreen> {
  bool switchColor = false;
  late RideBookingBloc _rideBookingBloc;
  late RideBookedBloc _rideBookedBloc;
  @override
  void initState() {
    _rideBookingBloc = BlocProvider.of<RideBookingBloc>(context);
    _rideBookedBloc = BlocProvider.of<RideBookedBloc>(context);
    _rideBookingBloc.add(GetAmAppoinmentsEvent());
    _rideBookingBloc.add(GetPmAppoinmentsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: ColorsExtensions.setColorOfContainersOverMap(context),
        borderRadius: BorderRadius.circular(ValuesManager.v16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: ValuesManager.v16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<RideBookingBloc, RideBookingState>(
              builder: (context, state) {
                return Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      if (_rideBookedBloc.rideVisible) {
                        String newCode = StringsExtensions.generateQR(
                            _rideBookingBloc.timeOfSelectedRides);
                        _rideBookedBloc.add(RescheduleRideEvent(Reschedule(
                            perfs.getInt(ConstantsManager.bookingID)!,
                            newCode,
                            Appointments(_rideBookingBloc
                                        .dictionaryOfAmTimeAndId[
                                    _rideBookingBloc.timeOfSelectedRides] ??
                                _rideBookingBloc.dictionaryOfAmTimeAndId[
                                    _rideBookingBloc.timeOfSelectedRides]!))));
                      }
                      Navigator.of(context).pop();
                    },
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
            BlocBuilder<RideBookingBloc, RideBookingState>(
              builder: (context, state) {
                return BusTimes(
                  times: _rideBookingBloc.titlesOfAm,
                  amOrPm: 'AM',
                );
              },
            ),
            BlocBuilder<MapBloc, MapState>(
              builder: (context, state) {
                return Visibility(
                  visible: switchColor,
                  child: BusTimes(
                    times: _rideBookingBloc.titlesOfPm,
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
