import 'package:easy_localization/easy_localization.dart';
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
              width: ValuesManager.v300,
              height: ValuesManager.v300,
            ),
            const SizedBox(
              height: ValuesManager.v10,
            ),
            TextWidget(
              text: StringManager.thankYou.tr(),
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontSize: ValuesManager.v18),
            ),
            const SizedBox(
              height: ValuesManager.v10,
            ),
            ButtonWidget(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(Routes.home, (route) => false);
              },
              child: TextWidget(
                text: StringManager.finish.tr(),
                style: Theme.of(context).textTheme.headline6!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
