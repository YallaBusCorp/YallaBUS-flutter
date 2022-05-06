import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/custom_widgets/Decoration_widget.dart';
import '../../../../core/custom_widgets/separtor_widget.dart';
import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../home/presentation/widgets/painting.dart';

class FromToBody extends StatelessWidget {
  const FromToBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecorationBoxWidget(
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
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: ValuesManager.v16,
                        ),
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: TextWidget(
                      text: 'Aga',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontSize: ValuesManager.v20,
                          ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: ValuesManager.v8),
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
                      style: Theme.of(context).textTheme.headline5!.copyWith(
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
    );
  }
}
