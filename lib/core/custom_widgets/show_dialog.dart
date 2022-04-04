import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yalla_bus/core/custom_widgets/animation_widget.dart';
import 'package:yalla_bus/core/custom_widgets/button_widget.dart';
import 'package:yalla_bus/core/custom_widgets/text_widget.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/colors_manager.dart';

import '../resources/values_manager.dart';

void DialogWidget(BuildContext context, String message, String type) {
  showDialog(
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              type == 'Loading'
                  ? CircularProgressIndicator(
                      color: ColorsManager.orange,
                      strokeWidth: 5,
                    )
                  : const Icon(
                      Icons.error_rounded,
                      color: Colors.red,
                      size: 50,
                    ),
              const SizedBox(
                height: 10,
              ),
              TextWidget(
                  text: message.tr(), style: Theme.of(context).textTheme.headline6!),
            ],
          ),
          actions: type == 'Error'
              ? [
                  Center(
                    child: ButtonWidget(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: Text('Close',
                          style: Theme.of(context).textTheme.headline6),
                      width: 100,
                      height: 50,
                    ),
                  ),
                ]
              : null,
        );
      },
      context: context);
}
