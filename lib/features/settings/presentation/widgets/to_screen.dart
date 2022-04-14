import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/resources/colors_manager.dart';

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
            width: 25,
            height: 25,
            color: ColorsManager.orange,
          ),
          const SizedBox(
            width: 8,
          ),
          TextWidget(
            text: text,
            style:
                Theme.of(context).textTheme.headline5!.copyWith(fontSize: 21),
          ),
          const Spacer(),
          Icon(Icons.arrow_circle_right_outlined,
              size: 30, color: Theme.of(context).iconTheme.color),
        ],
      ),
    );
  }
}
