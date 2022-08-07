import 'package:flutter/material.dart';

class CommingSoon extends StatelessWidget {
  const CommingSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 10,
          ),
          Text('Comming soon ..',
              style: Theme.of(context).textTheme.headline6!),
        ],
      ),
    );
  }
}
