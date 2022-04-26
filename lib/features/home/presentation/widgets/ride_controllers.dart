import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yalla_bus/core/custom_widgets/button_widget.dart';
import 'package:yalla_bus/core/custom_widgets/text_widget.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/resources/values_manager.dart';

class RideControllers extends StatelessWidget {
  const RideControllers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ValuesManager.v16),
        boxShadow: selectShadow(context),
        color: Theme.of(context).backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ButtonWidget(
                  onPressed: () {},
                  child: Row(
                   
                    children: [
                      SvgPicture.asset(
                        AssetManager.scan,
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      TextWidget(
                        text: 'QR code',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: 16),
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
            ButtonWidget(
              onPressed: () {},
              child: SvgPicture.asset(
                AssetManager.reschedule,
                width: 30,
                height: 30,
              ),
              width: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            ButtonWidget(
              onPressed: () {},
              child: SvgPicture.asset(
                AssetManager.cancelIcon,
                width: 30,
                height: 30,
              ),
              width: 50,
            ),
          ],
        ),
      ),
    );
  }
}
