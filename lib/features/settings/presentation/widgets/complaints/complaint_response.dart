import 'package:flutter/material.dart';
import 'package:yalla_bus/core/custom_widgets/Decoration_widget.dart';

class ComplaintResponse extends StatelessWidget {
  const ComplaintResponse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecorationBoxWidget(
      radius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
        bottomLeft: Radius.circular(0),
        bottomRight: Radius.circular(0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: Text('Complaints',
                        style: Theme.of(context).textTheme.headline5)),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Done',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            DecorationBoxWidget(
              radius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Yallawy Yallawy Yallawy',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '08:20 AM 12 March',
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(
                  'You',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: 18),
                ),
                const CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.green,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            DecorationBoxWidget(
              radius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(16),
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Thyhk Trab ya ghaly',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.green,
                ),
                Text(
                  'You',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: 18),
                ),
                Text(
                  '08:20 AM 12 March',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
