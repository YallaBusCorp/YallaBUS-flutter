import 'package:flutter/material.dart';
import 'separtor_widget.dart';
import 'text_widget.dart';
import '../extensions/extensions.dart';

import '../resources/asset_manager.dart';
import '../resources/colors_manager.dart';
import '../resources/string_manager.dart';
import '../resources/values_manager.dart';

class YesNoDialog extends StatelessWidget {
  final String? labelTap1;
  final String? labelTap2;
  final GestureTapCallback? onTap;
  const YesNoDialog(
      {Key? key,
      required this.message,
      required this.onTap,
      this.labelTap1,
      this.labelTap2})
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
          Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 0),
            child: Text(
              message,
              style:
                  Theme.of(context).textTheme.headline6!.copyWith(fontSize: 18),
              textAlign: TextAlign.center,
            ),
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
                        text: labelTap1 ?? StringManager.signOut,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontSize: 18,
                              color: Colors.blue[900],
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: ValuesManager.v1,
                height: ValuesManager.v15,
                color: Colors.grey.shade800,
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
                        text: labelTap2 ?? StringManager.returnStatement,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.blue[900],
                              fontSize: 18,
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
