import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';
import 'package:yalla_bus/core/resources/asset_manager.dart';
import 'package:yalla_bus/core/resources/constants.dart';
import 'package:yalla_bus/core/resources/routes_manager.dart';
import 'package:yalla_bus/core/resources/string_manager.dart';
import 'package:yalla_bus/features/onBoarding/pages/page_1.dart';
import 'package:yalla_bus/features/onBoarding/pages/page_2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:yalla_bus/core/injection/di.dart';
import 'page_3.dart';

class OnBoardingBase extends StatefulWidget {
  const OnBoardingBase({Key? key}) : super(key: key);

  @override
  State<OnBoardingBase> createState() => _OnBoardingBaseState();
}

class _OnBoardingBaseState extends State<OnBoardingBase> {
  PageController controller = PageController();
  final SharedPreferences perfs = di<SharedPreferences>();
  int index = 0;
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
                  .headline6!
                  .copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
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
              height: MediaQuery.of(context).size.height - 250,
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
            SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: WormEffect(
                dotWidth: 9,
                activeDotColor:
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                dotHeight: 9,
                spacing: 4,
                radius: 10,
                dotColor: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: ColorsManager.orange,
                maximumSize: const Size(78, 78),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                if (index == 2) {
                  seeOnBoarding();
                }
                controller.nextPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeIn);
              },
              child: Center(
                child: SvgPicture.asset(
                  AssetManager.arrow,
                  color: Colors.white,
                  width: 35,
                  height: 35,
                ),
              ),
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
    Navigator.of(context).pushReplacementNamed(Routes.chooseCompany);
  }
}
