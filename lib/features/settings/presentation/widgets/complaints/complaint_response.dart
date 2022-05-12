import 'package:flutter/material.dart';
import 'package:yalla_bus/core/custom_widgets/Decoration_widget.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';

import '../../../../../core/resources/colors_manager.dart';

class ComplaintResponse extends StatelessWidget {
  const ComplaintResponse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecorationBoxWidget(
      color: ColorsExtensions.setColorOfContainersOverMap(context),
      radius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
        bottomLeft: Radius.circular(0),
        bottomRight: Radius.circular(0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
         
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {},
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  'Done',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: 18, color: ColorsManager.orange),
                ),
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: Text('Complaints',
                    style: Theme.of(context).textTheme.headline5)),
            const SizedBox(
              height: 20,
            ),
            DecorationBoxWidget(
              radius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
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
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'You',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: 18),
                ),
                const SizedBox(
                  width: 5,
                ),
                const CircleAvatar(
                  radius: 10,
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
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Thyhk Trab ya ghaly',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.blue,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Unibus',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: 18),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '08:20 AM 12 March',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
