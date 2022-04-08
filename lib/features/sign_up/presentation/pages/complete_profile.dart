import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yalla_bus/core/custom_widgets/button_widget.dart';
import 'package:yalla_bus/core/custom_widgets/text_widget.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';
import 'package:yalla_bus/core/resources/routes_manager.dart';
import 'package:yalla_bus/core/resources/string_manager.dart';
import 'package:yalla_bus/core/resources/values_manager.dart';
import 'package:yalla_bus/features/sign_up/presentation/widgets/drop_down_widget.dart';

import '../../../../core/extensions/extensions.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  //Create bloc to make a call to get a list of university and towns

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  List<bool> tapped = [false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: TextWidget(
            text: StringManager.compeletProfile,
            style: Theme.of(context).textTheme.headline5!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(ValuesManager.v16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AssetManager.completeProfileIll,
              width: ValuesManager.v250,
              height: ValuesManager.v250,
            ),
            const SizedBox(
              height: ValuesManager.v5,
            ),
            //Edit Widget itself
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 15,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: ValuesManager.v5),
                  child: TextFormField(
                    controller: _firstNameController,
                    decoration: TextFormStyle.applyDecoration(
                        StringManager.firstName, Icons.person, context),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 15,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: ValuesManager.v5),
                  child: TextFormField(
                    controller: _lastNameController,
                    decoration: TextFormStyle.applyDecoration(
                        StringManager.lastName.tr(), Icons.person, context),
                  ),
                ),
              ),
            ),

            const DropDownWidget(
                hint: StringManager.town, options: ConstantsManager.towns),
            const DropDownWidget(
                hint: StringManager.university,
                options: ConstantsManager.universities),
            const Spacer(),
            ButtonWidget(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.addPayment);
              },
              child: Text(StringManager.continueToPayment,
                  style: Theme.of(context).textTheme.headline6!),
            ),
          ],
        ),
      ),
    );
  }
}
