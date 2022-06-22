import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yalla_bus/features/home/presentation/widgets/ride_booked/ride_info.dart';
import 'package:yalla_bus/features/settings/domain/entity/ride_history_model.dart';
import '../../../../../core/custom_widgets/button_widget.dart';
import '../../../../../core/resources/asset_manager.dart';
import '../../../../../core/resources/colors_manager.dart';
import '../book_ride.dart';
import 'qr_view.dart';

class RideOptions extends StatelessWidget {
  final RideHis ride;
  const RideOptions({Key? key, required this.ride}) : super(key: key);

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
                color: Colors.white,
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
              onPressed: () {},
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
          ride: ride,
        )),
        const SizedBox(
          width: 10,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ButtonWidget(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (builder) => const BookRideScreen(),
                );
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
              onPressed: () {},
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
