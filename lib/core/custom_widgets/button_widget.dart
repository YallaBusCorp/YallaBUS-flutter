import 'package:flutter/material.dart';

import '../resources/colors_manager.dart';

class ButtonWidget extends StatelessWidget {
  final Function? func;
  final Widget child;
  const ButtonWidget({Key? key, required this.func, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){},
      child: child,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(MediaQuery.of(context).size.width - 50, 40),
        primary: ColorsManager.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
