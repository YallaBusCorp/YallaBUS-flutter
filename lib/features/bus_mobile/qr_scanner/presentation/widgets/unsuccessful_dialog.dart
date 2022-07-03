import 'package:flutter/material.dart';
import '../../../../../core/custom_widgets/text_widget.dart';
import '../../../../../core/resources/asset_manager.dart';
import '../../../../../core/resources/values_manager.dart';

class InvalidDialog extends StatelessWidget {
  final String message;
  const InvalidDialog({Key? key, required this.message}) : super(key: key);

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
              image: AssetImage(
                AssetManager.cancel,
              ),
              width: 50,
              height: 50,
            ),
          ),
          const SizedBox(
            width: ValuesManager.v10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextWidget(
              text: message,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
          ),
          const SizedBox(
            height: ValuesManager.v20,
          ),
        ],
      ),
    );
  }
}
