import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yalla_bus/features/home/presentation/widgets/ride_booked/ride_info.dart';
import '../../../../../core/custom_widgets/button_widget.dart';
import '../../../../../core/custom_widgets/text_widget.dart';
import '../../../../../core/resources/asset_manager.dart';
import '../../../../../core/resources/colors_manager.dart';
import '../../../../../core/resources/constants_manager.dart';
import '../../bloc/map/map_bloc.dart';
import '../book_ride.dart';
import 'qr_view.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/injection/di.dart';
import '../../../../../core/resources/values_manager.dart';

class RideOptions extends StatelessWidget {
  const RideOptions({Key? key}) : super(key: key);

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
        const Expanded(child: RideInfo()),
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
