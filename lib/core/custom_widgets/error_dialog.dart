import 'package:flutter/material.dart';
import 'package:yalla_bus/core/custom_widgets/separtor_widget.dart';
import 'package:yalla_bus/core/custom_widgets/text_widget.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/colors_manager.dart';
import 'package:yalla_bus/core/resources/string_manager.dart';
import 'package:yalla_bus/core/resources/values_manager.dart';

import '../extensions/extensions.dart';

class ErrorDialog extends StatelessWidget {
  final GestureTapCallback? onTap;
  const ErrorDialog({Key? key, required this.message, required this.onTap})
      : super(key: key);
  final String message;
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
              image: AssetImage(AssetManager.cancel),
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
                .headline4!
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
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(ValuesManager.v16),
                  child: InkWell(
                    onTap: onTap,
                    child: Center(
                      child: TextWidget(
                        text: StringManager.retry,
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
                height: ValuesManager.v10,
                color: Colors.grey,
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
                        text: StringManager.close,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
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
    );
  }
}
