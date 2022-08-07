import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/injection/di.dart';
import '../../../../core/resources/asset_manager.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/constants_manager.dart';
import '../../../../core/resources/values_manager.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SharedPreferences perfs = di<SharedPreferences>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: ValuesManager.v110,
          height: ValuesManager.v110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ValuesManager.v100),
          ),
          child: Lottie.asset(
            AssetManager.profileAnimation,
            fit: BoxFit.cover,
            repeat: false,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: ValuesManager.v10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                    text: FirebaseAuth.instance.currentUser!.displayName ??
                        perfs.getString(ConstantsManager.userName)!,
                    style: Theme.of(context).textTheme.headline5!),
                const SizedBox(
                  height: ValuesManager.v5,
                ),
                InkWell(
                  onTap: () {
                  },
                  child: TextWidget(
                    text: 'Edit Profile',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: ValuesManager.v18,
                        color: ColorsManager.orange),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
