import 'package:flutter/material.dart';
import 'package:yalla_bus/core/custom_widgets/separtor_widget.dart';
import 'package:yalla_bus/core/custom_widgets/text_widget.dart';

import '../resources/asset_manager.dart';
import '../resources/colors_manager.dart';
import '../resources/string_manager.dart';
import '../resources/values_manager.dart';

class YesNoDialog extends StatelessWidget {
  final GestureTapCallback? onTap;
  const YesNoDialog({Key? key, required this.message, required this.onTap})
      : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(ValuesManager.v16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            
            TextWidget(
              text: message,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: ValuesManager.v20,
            ),
            Separtor(
              color: [
                Colors.grey.shade200,
                Colors.grey.shade200,
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(ValuesManager.v16),
                    child: InkWell(
                      onTap: onTap,
                      child: Center(
                        child: TextWidget(
                          text: StringManager.yes,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: ColorsManager.orange),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: ValuesManager.v1,
                  height: ValuesManager.v15,
                  color: Colors.grey.shade300,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(ValuesManager.v16),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Center(
                        child: TextWidget(
                          text: StringManager.no,
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: ColorsManager.orange,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
