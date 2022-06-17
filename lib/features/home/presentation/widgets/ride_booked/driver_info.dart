import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/custom_widgets/button_widget.dart';
import '../../../../../core/custom_widgets/text_widget.dart';
import '../../../../../core/resources/asset_manager.dart';
import '../../../../../core/resources/colors_manager.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/resources/values_manager.dart';

class DriverInfo extends StatelessWidget {
  const DriverInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: false,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ValuesManager.v16),
         
          color: Theme.of(context).backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                AssetManager.driver,
                width: 60,
                height: 60,
                color: ColorsManager.orange,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'Mohamed Abdo',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    TextWidget(
                      text: 'ABC | 4444',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ButtonWidget(
                onPressed: () {},
                child: const Icon(Icons.call, size: 30, color: Colors.white),
                width: 70,
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
