import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yalla_bus/features/settings/domain/entity/ride_history_model.dart';
import '../../../../../core/custom_widgets/Decoration_widget.dart';
import '../../../../../core/custom_widgets/button_widget.dart';
import '../../../../../core/custom_widgets/text_widget.dart';
import '../../../../../core/resources/asset_manager.dart';
import '../../../../../core/resources/colors_manager.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../domain/enitity/ride.dart';

class DriverInfo extends StatelessWidget {
  final RideHis ride;
  const DriverInfo({Key? key, required this.ride}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: !true,
                child: Text(
                  'Ride has not started yet',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              Visibility(
                visible: true,
                child: Text(
                  ride.emp!,
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
                visible: true,
                child: DecorationBoxWidget(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      ride.busId!,
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
        const SizedBox(
          width: 40,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.ideographic,
          children: [
            TextWidget(
              text: '22',
              style:
                  Theme.of(context).textTheme.headline5!.copyWith(fontSize: 30),
            ),
            TextWidget(
              text: 'Km',
              style:
                  Theme.of(context).textTheme.headline5!.copyWith(fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }
}
