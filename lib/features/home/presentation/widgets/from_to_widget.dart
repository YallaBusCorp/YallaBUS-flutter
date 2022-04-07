import 'package:flutter/material.dart';
import 'package:yalla_bus/core/custom_widgets/text_widget.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';
import 'package:yalla_bus/core/resources/colors_manager.dart';
import 'package:yalla_bus/core/resources/values_manager.dart';
import 'package:yalla_bus/features/home/presentation/widgets/painting.dart';

import '../../../../core/custom_widgets/separtor_widget.dart';

class FromToWidget extends StatelessWidget {
  const FromToWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height - 240,
      left: 10,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 20,
          padding: const EdgeInsets.all(ValuesManager.v8),
          decoration: BoxDecoration(
            boxShadow: selectShadow(context),
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(ValuesManager.v16),
          ),
          child: Row(
            children: [
              const Painting(),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'From',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: ValuesManager.v16),
                    ),
                    TextWidget(
                      text: 'Mit Ghamr',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontSize: ValuesManager.v20),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: ValuesManager.v8),
                      child: Separtor(
                        color: [ColorsManager.blue2, ColorsManager.green],
                      ),
                    ),
                    TextWidget(
                      text: 'To',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: ValuesManager.v16),
                    ),
                    TextWidget(
                      text: 'MET',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontSize: ValuesManager.v20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
