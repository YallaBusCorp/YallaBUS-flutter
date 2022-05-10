import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yalla_bus/core/custom_widgets/Decoration_widget.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';

import '../../../../../core/custom_widgets/separtor_widget.dart';
import '../../../../../core/resources/colors_manager.dart';

class RideHistoryItem extends StatelessWidget {
  const RideHistoryItem({Key? key}) : super(key: key);

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
                        height: 10,
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          'Mit Ghamr',
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
                        height: 10,
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          'Mansoura University',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontSize: 18),
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
                    '08:20 AM 12 March',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Text(
                    'Mohamed Abdo',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 18),
                  ),
                  Text(
                    'ABC | 4444',
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
