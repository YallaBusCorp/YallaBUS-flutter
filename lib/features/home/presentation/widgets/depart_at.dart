import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yalla_bus/core/custom_widgets/button_widget.dart';
import 'package:yalla_bus/core/custom_widgets/text_widget.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';
import 'package:yalla_bus/core/resources/values_manager.dart';

class DepartAt extends StatelessWidget {
  const DepartAt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height - 110,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ValuesManager.v16),
                  boxShadow: selectShadow(context),
                  color: Theme.of(context).backgroundColor,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: ValuesManager.v16),
                  child: Row(
                    children: [
                      TextWidget(
                        text: 'Depart At:',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: 18),
                      ),
                      const SizedBox(width: 10),
                      TextButton(
                        onPressed: () {},
                        child: TextWidget(
                          text: 'Choose Ride   ',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          ButtonWidget(
            width: 65,
            height: 50,
            onPressed: () {},
            child: TextWidget(
              text: 'Go',
              style:
                  Theme.of(context).textTheme.headline5!.copyWith(fontSize: 25),
            ),
          ),
        ],
      ),
    );
  }
}
