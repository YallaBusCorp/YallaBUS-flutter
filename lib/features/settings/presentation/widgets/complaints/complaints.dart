import 'package:flutter/material.dart';
import '../../../../../core/resources/routes_manager.dart';
import 'complaint_body.dart';

import '../../../../../core/resources/colors_manager.dart';

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
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.fileComplaint);
            },
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
