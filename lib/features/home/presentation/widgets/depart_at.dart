import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_bus/core/custom_widgets/error_dialog.dart';
import 'package:yalla_bus/core/custom_widgets/success_dialog.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';
import 'package:yalla_bus/features/home/domain/enitity/ride.dart';
import '../../../../core/custom_widgets/button_widget.dart';
import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../bloc/map/map_bloc.dart';
import 'book_ride.dart';

import '../../../../core/custom_widgets/loading_dialog.dart';

class DepartAt extends StatefulWidget {
  const DepartAt({Key? key}) : super(key: key);

  @override
  State<DepartAt> createState() => _DepartAtState();
}

class _DepartAtState extends State<DepartAt> {
  late MapBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<MapBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapBloc, MapState>(
      listener: (context, state) {
        if (state is Loading) {
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
              });
              return const Dialog(
                backgroundColor: Colors.transparent,
                child: SuccessDialog(
                  message: 'You have booked a ride !',
                ),
              );
            },
          );
          bloc.add(GetCurrentRideByUIDEvent(
              bloc.perfs.getString(ConstantsManager.uid)!));
          bloc.add(CameraPositionAfterBookingEvent());
          Navigator.of(context).pop();
        }
        if (state is BookRideError) {
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
          visible: bloc.departAndFromToVisible,
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
                              builder: (builder) => const BookRideScreen());
                        },
                        child: TextWidget(
                          text: bloc.timeOfSelectedRides,
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: ColorsExtensions.checkSelectedOrNot(
                                        bloc.timeOfSelectedRides,
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
                            bloc.add(
                              BookRideEvent(
                                Ride(
                                  qrCode: await StringsExtensions.generateQR(
                                      bloc.perfs.getString(
                                          ConstantsManager.dateOfRide)!),
                                  pickupPoint: PickUpPoint(bloc.pickUpID),
                                  dropOffPoint: DropOffPoint(bloc.dropOffID),
                                  appointment: Appointments(bloc.amTimeAndID[
                                          bloc.timeOfSelectedRides] ??
                                      bloc.pmTimeAndID[
                                          bloc.timeOfSelectedRides]!),
                                  std: StudentID(bloc.perfs
                                      .getInt(ConstantsManager.stdId)!),
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
    if (BlocProvider.of<MapBloc>(context).timeOfSelectedRides !=
            StringManager.timeOfSelectedRides &&
        BlocProvider.of<MapBloc>(context).from != StringManager.pickUpPoint &&
        BlocProvider.of<MapBloc>(context).to != StringManager.to) {
      return true;
    }
    return false;
  }
}
