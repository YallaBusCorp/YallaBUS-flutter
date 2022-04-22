import 'package:flutter/material.dart';
import 'package:yalla_bus/core/custom_widgets/separtor_widget.dart';
import 'package:yalla_bus/core/custom_widgets/text_widget.dart';

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
          Padding(
            padding: const EdgeInsets.all(ValuesManager.v16),
            child: Icon(
              Icons.done,
              color: ColorsManager.orange,
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
          const Separtor(
            color: [
              Color.fromARGB(255, 97, 93, 93),
              Color.fromARGB(255, 97, 93, 93)
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
