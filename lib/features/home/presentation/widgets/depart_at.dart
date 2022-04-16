import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yalla_bus/core/custom_widgets/button_widget.dart';
import 'package:yalla_bus/core/custom_widgets/text_widget.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';
import 'package:yalla_bus/core/resources/string_manager.dart';
import 'package:yalla_bus/core/resources/values_manager.dart';

class DepartAt extends StatelessWidget {
  const DepartAt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height - ValuesManager.v110,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(ValuesManager.v10),
            child: Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ValuesManager.v16),
                  boxShadow: selectShadow(context),
                  color: ColorsExtensions.setColorOfContainersOverMap(context),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: ValuesManager.v16),
                  child: Row(
                    children: [
                      TextWidget(
                        text: StringManager.departAt.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: ValuesManager.v18),
                      ),
                      const SizedBox(width: ValuesManager.v10),
                      TextButton(
                        onPressed: () {},
                        child: TextWidget(
                          text: StringManager.chooseRide.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontSize: ValuesManager.v18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          ButtonWidget(
            width: ValuesManager.v65,
            height: ValuesManager.v50,
            onPressed: () {},
            child: TextWidget(
              text: StringManager.go,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontSize: ValuesManager.v25),
            ),
          ),
        ],
      ),
    );
  }
}
