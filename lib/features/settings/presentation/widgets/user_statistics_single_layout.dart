import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/values_manager.dart';

class UserStatisticsSingleLayout extends StatelessWidget {
  final String asset;
  final String statisitcsNumber;
  final String description;
  const UserStatisticsSingleLayout(
      {Key? key,
      required this.asset,
      required this.statisitcsNumber,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ValuesManager.v25),
        color: Theme.of(context).backgroundColor,
        boxShadow: selectShadow(context),
      ),
      child: Padding(
        padding: const EdgeInsets.all(ValuesManager.v16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              asset,
              width: ValuesManager.v30,
              height: ValuesManager.v30,
              color: ColorsManager.orange,
            ),
            TextWidget(
              text: statisitcsNumber,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontSize: ValuesManager.v22),
            ),
            TextWidget(
                text: description, style: Theme.of(context).textTheme.caption!),
          ],
        ),
      ),
    );
  }
}
