import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/values_manager.dart';

class ToScreen extends StatelessWidget {
  final String asset;
  final String text;
  const ToScreen({Key? key, required this.asset, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
