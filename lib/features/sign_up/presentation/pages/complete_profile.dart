import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yalla_bus/core/custom_widgets/button_widget.dart';
import 'package:yalla_bus/core/custom_widgets/text_form.dart';
import 'package:yalla_bus/core/custom_widgets/text_widget.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';
import 'package:yalla_bus/core/resources/routes_manager.dart';
import 'package:yalla_bus/core/resources/string_manager.dart';
import 'package:yalla_bus/core/resources/values_manager.dart';
import 'package:yalla_bus/features/sign_up/presentation/widgets/drop_down_widget.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  //Create bloc to make a call to get a list of university and towns
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
            const TextFormWidget(
              text: StringManager.firstName,
              width: double.infinity,
              icon: Icons.person,
            ),
            const TextFormWidget(
              text: StringManager.lastName,
              width: double.infinity,
              icon: Icons.person,
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
              child: Text('Continue to payment',
                  style: Theme.of(context).textTheme.headline6!),
            ),
          ],
        ),
      ),
    );
  }
}
