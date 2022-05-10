import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yalla_bus/core/resources/routes_manager.dart';

import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/values_manager.dart';

class ToScreen extends StatelessWidget {
  final String asset;
  final String text;
  final int index;
  const ToScreen(
      {Key? key, required this.asset, required this.text, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        switch (index) {
          case 0:
            Navigator.of(context).pushNamed(Routes.rideHistory);
            break;
          case 1:
            Navigator.of(context).pushNamed(Routes.subscriptionDetails);
            break;
          case 6:
            Navigator.of(context).pushNamed(Routes.complaints);
            break;
          default:
        }
      },
      child: Row(
        children: [
          SvgPicture.asset(
            asset,
            width: ValuesManager.v25,
            height: ValuesManager.v25,
            color: ColorsManager.orange,
          ),
          const SizedBox(
            width: ValuesManager.v8,
          ),
          TextWidget(
            text: text,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontSize: ValuesManager.v20),
          ),
          const Spacer(),
          Icon(Icons.arrow_circle_right_outlined,
              size: ValuesManager.v30,
              color: Theme.of(context).iconTheme.color),
        ],
      ),
    );
  }
}
