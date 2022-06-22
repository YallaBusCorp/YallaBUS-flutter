import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../core/custom_widgets/Decoration_widget.dart';
import '../../../../../core/extensions/extensions.dart';

import '../../../../../core/custom_widgets/separtor_widget.dart';
import '../../../../../core/resources/colors_manager.dart';
import '../../../domain/entity/ride_history_model.dart';

class RideHistoryItem extends StatelessWidget {
  final RideHis rideHis;
  const RideHistoryItem({Key? key, required this.rideHis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecorationBoxWidget(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('From',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontSize: 18)),
                      const SizedBox(
                        height: 5,
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          rideHis.pick.name,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Text('To',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(fontSize: 18)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            rideHis.drop.name,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: 12,
                height: 20,
                decoration: BoxDecoration(
                  color: ColorsExtensions.setColorOfContainersOverMap(context),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                  ),
                ),
              ),
              Expanded(
                child: Separtor(
                  color: [ColorsManager.blue2, ColorsManager.green],
                ),
              ),
              Container(
                width: 12,
                height: 20,
                decoration: BoxDecoration(
                  color: ColorsExtensions.setColorOfContainersOverMap(context),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(100),
                    bottomLeft: Radius.circular(100),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    StringsExtensions.removeSecondsFromDate(
                        rideHis.appoinment.date, rideHis.appoinment.amOrPm),
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Text(
                    rideHis.emp,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 18),
                  ),
                  Text(
                    rideHis.busId,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
