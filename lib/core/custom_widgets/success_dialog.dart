import 'package:flutter/material.dart';
import 'package:yalla_bus/core/custom_widgets/separtor_widget.dart';
import 'package:yalla_bus/core/custom_widgets/text_widget.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';

import '../extensions/extensions.dart';
import '../resources/colors_manager.dart';
import '../resources/string_manager.dart';
import '../resources/values_manager.dart';

class SuccessDialog extends StatelessWidget {
  final String message;
  const SuccessDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(ValuesManager.v16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(ValuesManager.v16),
            child: Image(
              image: AssetImage(
                AssetManager.done,
              ),
              width: 50,
              height: 50,
            ),
          ),
          const SizedBox(
            width: ValuesManager.v10,
          ),
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
                Colors.grey.shade800,
                Colors.grey.shade800,
              ],
            ),
          Padding(
            padding: const EdgeInsets.all(ValuesManager.v16),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Center(
                child: TextWidget(
                  text: StringManager.close,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: ColorsManager.orange),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
