import 'package:flutter/material.dart';
import 'package:yalla_bus/features/settings/presentation/widgets/complaint_body.dart';

import '../../../../core/resources/colors_manager.dart';

class Complaints extends StatelessWidget {
  const Complaints({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Complaints',
          style: Theme.of(context).textTheme.headline5,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
            iconSize: 30,
            color: ColorsManager.orange,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: 2,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return const ComplaintBody();
          },
        ),
      ),
    );
  }
}