import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yalla_bus/core/custom_widgets/button_widget.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/routes_manager.dart';
import 'package:yalla_bus/core/resources/values_manager.dart';

import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/resources/string_manager.dart';

class SuccessPayment extends StatelessWidget {
  const SuccessPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AssetManager.successfulPurchase,
              width: ValuesManager.v500,
              height: ValuesManager.v500,
            ),
            const SizedBox(
              height: 10,
            ),
            TextWidget(
              text: 'Thank you! Payment was Successful',
              style:
                  Theme.of(context).textTheme.headline6!.copyWith(fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonWidget(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(Routes.home, (route) => false);
              },
              child: TextWidget(
                text: 'Finish',
                style: Theme.of(context).textTheme.headline6!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
