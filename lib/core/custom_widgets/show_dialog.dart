import 'package:flutter/material.dart';
import 'package:yalla_bus/core/custom_widgets/button_widget.dart';

void showDialogWidget(BuildContext context, String message) {
  showDialog(
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey,
          title: Text(
            message,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          actions: [
            ButtonWidget(
              onPressed: () {
                Navigator.of(context,rootNavigator: true).pop();
              },
              child:
                  Text('Cancel', style: Theme.of(context).textTheme.subtitle2),
              height: 20,
              width: 100,
            ),
          ],
        );
      },
      context: context);
}
