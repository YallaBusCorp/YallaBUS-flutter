import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yalla_bus/core/custom_widgets/animation_widget.dart';
import 'package:yalla_bus/core/custom_widgets/button_widget.dart';
import 'package:yalla_bus/core/custom_widgets/text_widget.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/colors_manager.dart';

import '../resources/values_manager.dart';

void DialogWidget(BuildContext context, String message,String type) {
  showDialog(
   
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize : MainAxisSize.min,
            children: [
              type == 'Loading' ? CircularProgressIndicator(color: ColorsManager.orange,strokeWidth: 5,) : Icon(Icons.error_rounded,color: Colors.red,size: 50,),
              const SizedBox(
                height: 10,
              ),
              TextWidget(
                  text: message,
                  style: Theme.of(context).textTheme.subtitle1!),
            ],
          ),
        );
      },
      context: context);
}
