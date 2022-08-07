import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/custom_widgets/Decoration_widget.dart';
import '../../../../../core/custom_widgets/button_widget.dart';
import '../../../../../core/custom_widgets/error_dialog.dart';
import '../../../../../core/resources/asset_manager.dart';
import '../../../../../core/resources/colors_manager.dart';
import '../../../../../core/resources/constants_manager.dart';
import '../../../domain/enitity/reschedule_body.dart';
import '../../../domain/enitity/returned_ride.dart';
import '../../../domain/enitity/ride.dart';
import '../../bloc/ride_booking/ride_booking_bloc.dart';
import '../book_ride.dart';
import 'qr_view.dart';
import '../../../../../core/custom_widgets/loading_dialog.dart';
import '../../../../../core/custom_widgets/success_dialog.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../settings/domain/entity/ride_history_model.dart';
import '../../bloc/map/map_bloc.dart';
import '../../bloc/ride_booked/ride_booked_bloc.dart';
import 'driver_info.dart';
import 'ride_option.dart';

class RideBooked extends StatefulWidget {
  const RideBooked({Key? key}) : super(key: key);

  @override
  State<RideBooked> createState() => _RideBookedState();
}

class _RideBookedState extends State<RideBooked> {
  late MapBloc _mapBloc;
  late RideBookedBloc _rideBookedBloc;
  late RideBookingBloc _rideBookingBloc;
  late RideHis ride;

  @override
  void initState() {
    _mapBloc = BlocProvider.of<MapBloc>(context);
    _rideBookedBloc = BlocProvider.of<RideBookedBloc>(context);
    _rideBookingBloc = BlocProvider.of<RideBookingBloc>(context);
    ride = RideHis(
      -1,
      'sdgfsagasgs',
      PickUp('name', 30.32523, 31.235235),
      DropOff('name', 30.32523, 31.235235),
      Appoint(
        _rideBookingBloc.timeOfSelectedRides.substring(0, 5),
        _rideBookingBloc.timeOfSelectedRides.substring(6, 8),
      ),
      Bus(1, "busUid", "phone", "busLicenceNumber"),
      Employee(1, CompanyId(1), "empCode", "empName"),
      TxRide(1, 'pending'),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RideBookedBloc, RideBookedState>(
      listener: (context, state) {
        if (state is StudentInCurrentRide) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          ride = state.ride;
        }
        if (state is StudentNotInCurrentRide) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
        if (state is LoadingOfBooked) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => const Dialog(
              backgroundColor: Colors.transparent,
              child: LoadingDialog(),
            ),
          );
        }
        if (state is StudentCurrentRideError) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => Dialog(
              backgroundColor: Colors.transparent,
              child: ErrorDialog(
                message: state.message,
                onTap: () {
                  _rideBookedBloc.add(GetCurrentRideByUIDEvent(
                      _rideBookedBloc.perfs.getString(ConstantsManager.uid)!,
                      context));
                },
              ),
            ),
          );
        }

        if (state is CancelRideSuccess) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.of(context).pop();
              });
              return const Dialog(
                backgroundColor: Colors.transparent,
                child: SuccessDialog(
                  message: 'You canceled a ride !',
                ),
              );
            },
          );
          Navigator.of(context).pop();
          _rideBookedBloc.add(
            GetCurrentRideByUIDEvent(
                _rideBookedBloc.perfs.getString(ConstantsManager.uid)!,
                context),
          );
        }

        if (state is CancelRideError) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => Dialog(
              backgroundColor: Colors.transparent,
              child: ErrorDialog(
                message: state.message,
                onTap: () {
                  _rideBookedBloc.add(GetCurrentRideByUIDEvent(
                      _rideBookedBloc.perfs.getString(ConstantsManager.uid)!,
                      context));
                },
              ),
            ),
          );
        }

        if (state is RescheduleRideSuccess) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.of(context).pop();
              });
              return const Dialog(
                backgroundColor: Colors.transparent,
                child: SuccessDialog(
                  message: 'You rescheduled your ride!',
                ),
              );
            },
          );
        }
        if (state is StudentRideComplete) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
        if (state is RescheduleRideError) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => Dialog(
              backgroundColor: Colors.transparent,
              child: ErrorDialog(
                message: state.message,
                onTap: () {
                  _rideBookedBloc.add(
                    RescheduleRideEvent(
                      Reschedule(
                        ride.id!,
                        StringsExtensions.generateQR(
                            _rideBookingBloc.timeOfSelectedRides),
                        Appointments(_rideBookingBloc.dictionaryOfAmTimeAndId[
                                _rideBookingBloc.timeOfSelectedRides] ??
                            _rideBookingBloc.dictionaryOfPmTimeAndId[
                                _rideBookingBloc.timeOfSelectedRides]!),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return ride.id != -1 || _rideBookedBloc.rideVisible
            ? Visibility(
                visible: _rideBookedBloc.rideVisible,
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
                          const SizedBox(
                            height: 5,
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
