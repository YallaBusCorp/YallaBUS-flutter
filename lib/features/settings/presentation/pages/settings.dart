import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/custom_widgets/yes_no_dialog.dart';
import '../../../../core/resources/asset_manager.dart';
import '../../../../core/resources/colors_manager.dart';
import '../bloc/settings_bloc.dart';

import '../widgets/options.dart';
import '../widgets/user_statistics.dart';

import '../../../../core/resources/routes_manager.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../widgets/header.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsBloc bloc = BlocProvider.of<SettingsBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
            text: StringManager.settings.tr(),
            style: Theme.of(context).textTheme.headline5!),
        actions: [
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) => Dialog(
                  insetPadding: const EdgeInsets.all(25),
                  backgroundColor: Colors.transparent,
                  child: YesNoDialog(
                      message: 'Are you sure you want to sign out ?',
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.goodBye, (route) => false);
                      }),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SvgPicture.asset(
                AssetManager.signOut,
                color: ColorsManager.offRed2,
                width: 30,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(ValuesManager.v16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(),
            const UserStatistics(),
            const SizedBox(height: ValuesManager.v10),
            Options(),
          ],
        ),
      ),
    );
  }
}
