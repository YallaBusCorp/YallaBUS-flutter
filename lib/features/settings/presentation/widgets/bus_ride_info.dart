import 'package:flutter/material.dart';

import '../../../../core/custom_widgets/Decoration_widget.dart';
import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/extensions/extensions.dart';

class BusRideInfo extends StatelessWidget {
  const BusRideInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          DecorationBoxWidget(
            color: ColorsExtensions.setColorOfContainersOverMap(context),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: TextWidget(
                    text: '3hr 40m',
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
              color: ColorsExtensions.setColorOfContainersOverMap(context),
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
        ],
      ),
    );
  }
}
