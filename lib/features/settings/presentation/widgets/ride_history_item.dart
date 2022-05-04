import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yalla_bus/core/custom_widgets/Decoration_widget.dart';
import 'package:yalla_bus/core/custom_widgets/text_widget.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';
import 'package:yalla_bus/core/resources/string_manager.dart';
import 'package:yalla_bus/features/home/presentation/widgets/from_to_body.dart';

import '../../../../core/custom_widgets/separtor_widget.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../home/presentation/widgets/painting.dart';

class RideHistoryItem extends StatelessWidget {
  const RideHistoryItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecorationBoxWidget(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                    text: '08:20 AM 12 March',
                    style: Theme.of(context).textTheme.caption!),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.warning_rounded),
                  iconSize: 30,
                  color: ColorsManager.orange,
                )
              ],
            ),
            DecorationBoxWidget(
              color: ColorsExtensions.setColorOfContainersOverMap(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Painting(),
                    const SizedBox(width: ValuesManager.v10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: StringManager.from.tr(),
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      fontSize: ValuesManager.v16,
                                    ),
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: TextWidget(
                              text: 'Aga',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                    fontSize: ValuesManager.v20,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: ValuesManager.v8),
                            child: Separtor(
                              color: [ColorsManager.blue2, ColorsManager.green],
                            ),
                          ),
                          TextWidget(
                            text: StringManager.to.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(fontSize: ValuesManager.v16),
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: TextWidget(
                              text: 'MET',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                    fontSize: ValuesManager.v20,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  DecorationBoxWidget(
                    color:
                        ColorsExtensions.setColorOfContainersOverMap(context),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: TextWidget(
                            text: '60 km',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(fontSize: 18)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: DecorationBoxWidget(
                      color:
                          ColorsExtensions.setColorOfContainersOverMap(context),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(
                            children: [
                              Text('Mohamed Abdo',
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(fontSize: 18)),
                              TextWidget(
                                  text: 'ABC | 5604',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(fontSize: 18)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   width: 10,
                  // ),
                  // DecorationBoxWidget(
                  //   color:
                  //       ColorsExtensions.setColorOfContainersOverMap(context),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Center(
                  //       child: TextWidget(
                  //           text: '3hr 50m',
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .headline6!
                  //               .copyWith(fontSize: 18)),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
