import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/custom_widgets/comming_soon.dart';
import '../../../../../core/resources/constants_manager.dart';

import '../../../../../core/custom_widgets/Decoration_widget.dart';
import '../../../../../core/custom_widgets/separtor_widget.dart';
import '../../../../../core/custom_widgets/yes_no_dialog.dart';
import '../../../../../core/resources/asset_manager.dart';
import '../../../../../core/resources/colors_manager.dart';
import '../../../../../core/resources/routes_manager.dart';
import '../bloc/bus_ride_bloc.dart';

class BusSettings extends StatefulWidget {
  const BusSettings({Key? key}) : super(key: key);

  @override
  State<BusSettings> createState() => _BusSettingsState();
}

class _BusSettingsState extends State<BusSettings> {
  late BusRideBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<BusRideBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Advanced',
          style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 20),
        ),
        const SizedBox(
          height: 5,
        ),
        DecorationBoxWidget(
          radius: BorderRadius.circular(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.of(context).pop();
                      });
                      return const Dialog(
                        backgroundColor: Colors.transparent,
                        child: CommingSoon(),
                      );
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add fees',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: 18),
                      ),
                      SvgPicture.asset(
                        AssetManager.arrow,
                        width: 10,
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Separtor(
                color: [
                  Colors.grey.shade800,
                  Colors.grey.shade800,
                ],
              ),
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
                            bloc.add(SignOutEvent());
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                Routes.loginOtp, (route) => false,
                                arguments: ConstantsManager.register);
                          }),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Log out',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 18, color: ColorsManager.offRed),
                      ),
                      Icon(
                        Icons.delete,
                        size: 20,
                        color: ColorsManager.offRed,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
