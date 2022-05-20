// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalla_bus/core/injection/di.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/constants_manager.dart';
import 'package:yalla_bus/core/resources/routes_manager.dart';
import 'package:yalla_bus/core/resources/string_manager.dart';
import 'package:yalla_bus/core/resources/values_manager.dart';
import 'package:yalla_bus/features/onBoarding/pages/page_1.dart';
import 'package:yalla_bus/features/onBoarding/pages/page_2.dart';

import '../../../core/resources/colors_manager.dart';
import '../widgets/indicator.dart';
import 'page_3.dart';

class OnBoardingBase extends StatefulWidget {
  const OnBoardingBase({Key? key}) : super(key: key);

  @override
  State<OnBoardingBase> createState() => _OnBoardingBaseState();
}

class _OnBoardingBaseState extends State<OnBoardingBase> {
  PageController controller = PageController();
  final SharedPreferences perfs = di<SharedPreferences>();
  int index = ValuesManager.iv0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              seeOnBoarding();
            },
            child: Text(
              StringManager.skip.tr(),
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.grey, fontSize: 18),
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - ValuesManager.v250,
              child: PageView(
                controller: controller,
                onPageChanged: (i) {
                  setState(() {
                    index = i;
                  });
                },
                children: const [
                  Page1(),
                  Page2(),
                  Page3(),
                ],
              ),
            ),
            const SizedBox(height: ValuesManager.v10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: ColorsManager.orange,
                maximumSize: const Size(ValuesManager.v78, ValuesManager.v78),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                if (index == 2) {
                  seeOnBoarding();
                }
                controller.nextPage(
                    duration:
                        Duration(milliseconds: ValuesManager.v200.toInt()),
                    curve: Curves.easeIn);
              },
              child: Center(
                child: SvgPicture.asset(
                  AssetManager.arrow,
                  color: Colors.white,
                  width: ValuesManager.v35,
                  height: ValuesManager.v35,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Indicator(
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void seeOnBoarding() {
    perfs.setBool(ConstantsManager.seenKey, true);
    Navigator.of(context).pushReplacementNamed(Routes.loginOtp);
  }
}
