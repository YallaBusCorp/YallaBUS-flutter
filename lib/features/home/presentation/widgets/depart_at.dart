import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_bus/core/custom_widgets/button_widget.dart';
import 'package:yalla_bus/core/custom_widgets/text_widget.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';
import 'package:yalla_bus/core/resources/string_manager.dart';
import 'package:yalla_bus/core/resources/values_manager.dart';
import 'package:yalla_bus/features/home/presentation/bloc/map/map_bloc.dart';
import 'package:yalla_bus/features/home/presentation/widgets/book_ride.dart';

class DepartAt extends StatefulWidget {
  const DepartAt({Key? key}) : super(key: key);

  @override
  State<DepartAt> createState() => _DepartAtState();
}

class _DepartAtState extends State<DepartAt> {
  @override
  Widget build(BuildContext context) {
    MapBloc bloc = BlocProvider.of<MapBloc>(context);
    return Positioned(
      top: MediaQuery.of(context).size.height - ValuesManager.v110,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(ValuesManager.v10),
            child: Container(
              width: MediaQuery.of(context).size.width - 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ValuesManager.v16),
                boxShadow: selectShadow(context),
                color: ColorsExtensions.setColorOfContainersOverMap(context),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: ValuesManager.v16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextWidget(
                      text: StringManager.departAt.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: ValuesManager.v18),
                    ),
                    BlocBuilder<MapBloc, MapState>(
                      builder: (context, state) {
                        return TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (builder) => const BookRide());
                          },
                          child: TextWidget(
                            text: bloc.timeOfSelectedRides,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                  fontSize: perferedSize(
                                    bloc.timeOfSelectedRides,
                                  ),
                                  color: ColorsExtensions.checkSelectedOrNot(
                                      bloc.timeOfSelectedRides,
                                      StringManager.timeOfSelectedRides),
                                ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          BlocBuilder<MapBloc, MapState>(
            builder: (context, state) {
              return ButtonWidget(
                width: ValuesManager.v65,
                height: ValuesManager.v50,
                onPressed: checkValidation() == true ? () {} : null,
                child: TextWidget(
                  text: StringManager.go,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontSize: ValuesManager.v25),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  double perferedSize(String v) {
    if (v.length < 12) {
      return 18;
    } else {
      return 12;
    }
  }

  bool checkValidation() {
    if (BlocProvider.of<MapBloc>(context).timeOfSelectedRides !=
            StringManager.timeOfSelectedRides &&
        BlocProvider.of<MapBloc>(context).from != StringManager.pickUpPoint &&
        BlocProvider.of<MapBloc>(context).to != StringManager.to) {
      return true;
    }
    return false;
  }
}
