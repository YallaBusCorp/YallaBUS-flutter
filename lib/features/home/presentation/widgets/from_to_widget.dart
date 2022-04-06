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
      bottom: MediaQuery.of(context).size.height - 20,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(ValuesManager.v8),
          decoration: BoxDecoration(
            boxShadow: selectShadow(context),
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(ValuesManager.v16),
          ),
          child: Row(
            children: [
              const Painting(),
              Column(
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
                        .copyWith(fontSize: ValuesManager.v25),
                  ),
                  Separtor(
                    color: [ColorsManager.green, ColorsManager.blue2],
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
                        .copyWith(fontSize: ValuesManager.v25),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
