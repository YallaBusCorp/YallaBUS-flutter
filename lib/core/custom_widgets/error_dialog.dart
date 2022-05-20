import 'package:flutter/material.dart';
import 'separtor_widget.dart';
import 'text_widget.dart';
import '../resources/asset_manager.dart';
import '../resources/colors_manager.dart';
import '../resources/string_manager.dart';
import '../resources/values_manager.dart';

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
            padding: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 0),
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
                            .copyWith(color: Colors.blue[900]),
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
                        text: StringManager.cancel,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.blue[900],
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
