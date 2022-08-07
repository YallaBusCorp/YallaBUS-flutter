import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/custom_widgets/error_dialog.dart';
import '../../../../core/custom_widgets/success_dialog.dart';
import '../../../../core/resources/constants_manager.dart';
import '../../domain/enitity/ride.dart';
import '../bloc/map/pickup_dropoff_info.dart';
import '../../../../core/custom_widgets/button_widget.dart';
import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../bloc/map/map_bloc.dart';
import '../bloc/ride_booked/ride_booked_bloc.dart';
import '../bloc/ride_booking/ride_booking_bloc.dart';
import 'book_ride.dart';

import '../../../../core/custom_widgets/loading_dialog.dart';

class DepartAt extends StatefulWidget {
  const DepartAt({Key? key}) : super(key: key);

  @override
  State<DepartAt> createState() => _DepartAtState();
}

class _DepartAtState extends State<DepartAt> {
  late MapBloc _mapBloc;
  late RideBookingBloc _rideBookingBloc;
  late RideBookedBloc _rideBookedBloc;
  @override
  void initState() {
    _mapBloc = BlocProvider.of<MapBloc>(context);
    _rideBookingBloc = BlocProvider.of<RideBookingBloc>(context);
    _rideBookedBloc = BlocProvider.of<RideBookedBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RideBookingBloc, RideBookingState>(
      listener: (context, state) {
        if (state is LoadingOfBooking) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => const Dialog(
              backgroundColor: Colors.transparent,
              child: LoadingDialog(),
            ),
          );
        }
        if (state is BookRideSuccess) {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.of(context).pop();
                _rideBookedBloc.add(GetCurrentRideByUIDEvent(
                    _rideBookedBloc.perfs.getString(ConstantsManager.uid)!,
                    context));
                Navigator.of(context).pop();
                _mapBloc.add(CameraPositionAfterBookingEvent());
              });
              return const Dialog(
                backgroundColor: Colors.transparent,
                child: SuccessDialog(
                  message: 'You have booked a ride !',
                ),
              );
            },
          );
        }
        if (state is BookRideError) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (BuildContext context) => Dialog(
              backgroundColor: Colors.transparent,
              child: ErrorDialog(
                message: 'Server Error',
                onTap: () {},
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Visibility(
          visible: _rideBookedBloc.departAndFromToVisible,
          child: Positioned(
            top: MediaQuery.of(context).size.height - 80,
            child: SizedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(ValuesManager.v16),
                      color:
                          ColorsExtensions.setColorOfContainersOverMap(context),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: ValuesManager.v16),
                      child: TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (builder) => BookRideScreen());
                        },
                        child: TextWidget(
                          text: _rideBookingBloc.timeOfSelectedRides,
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: ColorsExtensions.checkSelectedOrNot(
                                        _rideBookingBloc.timeOfSelectedRides,
                                        StringManager.timeOfSelectedRides,
                                        context),
                                    fontSize: 18,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ButtonWidget(
                    width: ValuesManager.v65,
                    height: ValuesManager.v50,
                    onPressed: checkValidation() == true
                        ? () async {
                            _rideBookingBloc.add(
                              BookRideEvent(
                                Ride(
                                  qrCode: StringsExtensions.generateQR(
                                      _rideBookingBloc.perfs.getString(
                                          ConstantsManager.dateOfRide)!),
                                  pickupPoint: PickUpPoint(
                                      PickUpAndDropOffInfo.pickUpID),
                                  dropOffPoint: DropOffPoint(
                                      PickUpAndDropOffInfo.dropOffID),
                                  appointment: Appointments(_rideBookingBloc
                                              .dictionaryOfPmTimeAndId[
                                          _rideBookingBloc
                                              .timeOfSelectedRides] ??
                                      _rideBookingBloc.dictionaryOfPmTimeAndId[
                                          _rideBookingBloc
                                              .timeOfSelectedRides]!),
                                  std: StudentID(
                                      _rideBookingBloc.perfs
                                          .getInt(ConstantsManager.stdId)!,
                                      ''),
                                ),
                              ),
                            );
                          }
                        : null,
                    child: TextWidget(
                      text: StringManager.go,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontSize: ValuesManager.v25),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool checkValidation() {
    if (_rideBookingBloc.timeOfSelectedRides !=
            StringManager.timeOfSelectedRides &&
        _rideBookedBloc.from != StringManager.pickUpPoint &&
        _rideBookedBloc.to != StringManager.to) {
      return true;
    }
    return false;
  }
}
