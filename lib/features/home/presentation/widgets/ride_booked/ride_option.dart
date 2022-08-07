import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/custom_widgets/button_widget.dart';
import '../../../../../core/custom_widgets/yes_no_dialog.dart';
import '../../../../../core/resources/asset_manager.dart';
import '../../../../../core/resources/colors_manager.dart';
import '../../../../../core/resources/map_manager.dart';
import '../../../../bus_mobile/qr_scanner/presentation/widgets/unsuccessful_dialog.dart';
import '../../../../settings/domain/entity/ride_history_model.dart';
import '../../bloc/ride_booked/ride_booked_bloc.dart';
import '../book_ride.dart';
import 'qr_view.dart';
import 'ride_info.dart';

class RideOptions extends StatefulWidget {
  final RideHis ride;
  const RideOptions({Key? key, required this.ride}) : super(key: key);

  @override
  State<RideOptions> createState() => _RideOptionsState();
}

class _RideOptionsState extends State<RideOptions> {
  late RideBookedBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<RideBookedBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ButtonWidget(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const Dialog(
                      insetPadding: EdgeInsets.all(16),
                      child: QRView(),
                      backgroundColor: Colors.transparent),
                );
              },
              color: Theme.of(context).backgroundColor,
              child: SvgPicture.asset(
                AssetManager.scan,
                color:
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                width: 30,
                height: 30,
              ),
              width: 55,
              height: 55,
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return Dialog(
                        insetPadding: const EdgeInsets.all(16),
                        backgroundColor: Colors.transparent,
                        child: MapManager.markersOfBus.isNotEmpty
                            ? YesNoDialog(
                                message:
                                    'Are you sure you want to call a driver ?',
                                labelTap1: 'Yes',
                                labelTap2: 'No',
                                onTap: () {
                                  bloc.add(
                                      CallDriverEvent(widget.ride.bus!.phone));
                                  Navigator.of(context).pop();
                                },
                              )
                            : const InvalidDialog(
                                message:
                                    "You can call driver only when ride starts",
                              ),
                      );
                    });
              },
              color: Theme.of(context).backgroundColor,
              child: SvgPicture.asset(
                AssetManager.call,
                color: ColorsManager.green,
                width: 30,
                height: 30,
              ),
              width: 55,
              height: 55,
            ),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: RideInfo(
          ride: widget.ride,
        )),
        const SizedBox(
          width: 10,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ButtonWidget(
              onPressed: () {
                if (widget.ride.emp!.empName == 'TTTTTTTT') {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (builder) => const BookRideScreen(),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.of(context).pop();
                      });
                      return const Dialog(
                        backgroundColor: Colors.transparent,
                        child: InvalidDialog(
                          message: "You can't reschedule this ride",
                        ),
                      );
                    },
                  );
                }
              },
              color: Theme.of(context).backgroundColor,
              child: SvgPicture.asset(
                AssetManager.reschedule,
                color: ColorsManager.blue,
                width: 30,
                height: 30,
              ),
              width: 55,
              height: 55,
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return Dialog(
                        insetPadding: const EdgeInsets.all(16),
                        backgroundColor: Colors.transparent,
                        child: YesNoDialog(
                            message:
                                'Are you sure you want to cancel this ride ?',
                            labelTap1: 'Yes',
                            labelTap2: 'No',
                            onTap: () {
                              bloc.add(CancelRideEvent(widget.ride.id!));
                              Navigator.of(context).pop();
                            }),
                      );
                    });
              },
              color: Theme.of(context).backgroundColor,
              child: SvgPicture.asset(
                AssetManager.cancelSVG,
                color: ColorsManager.offRed,
                width: 30,
                height: 30,
              ),
              width: 55,
              height: 55,
            ),
          ],
        ),
      ],
    );
  }
}
