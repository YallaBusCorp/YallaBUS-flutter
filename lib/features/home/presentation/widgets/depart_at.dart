import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/custom_widgets/button_widget.dart';
import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../bloc/map/map_bloc.dart';
import 'book_ride.dart';

import '../../../../core/custom_widgets/loading_dialog.dart';

class DepartAt extends StatefulWidget {
  const DepartAt({Key? key}) : super(key: key);

  @override
  State<DepartAt> createState() => _DepartAtState();
}

class _DepartAtState extends State<DepartAt> {
  @override
  Widget build(BuildContext context) {
    MapBloc bloc = BlocProvider.of<MapBloc>(context);
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return Visibility(
          visible: !(bloc.perfs.getBool('Booked') ?? false),
          child: Positioned(
            top: MediaQuery.of(context).size.height - 80,
            child: SizedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(ValuesManager.v16),
                      boxShadow: selectShadow(context),
                      color:
                          ColorsExtensions.setColorOfContainersOverMap(context),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: ValuesManager.v16),
                      child: BlocBuilder<MapBloc, MapState>(
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
                                  .headline6!
                                  .copyWith(
                                    color: ColorsExtensions.checkSelectedOrNot(
                                        bloc.timeOfSelectedRides,
                                        StringManager.timeOfSelectedRides,
                                        context),
                                    fontSize: 18,
                                  ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  BlocBuilder<MapBloc, MapState>(
                    builder: (context, state) {
                      return ButtonWidget(
                        width: ValuesManager.v65,
                        height: ValuesManager.v50,
                        onPressed: checkValidation() == true
                            ? () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      const Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: LoadingDialog(),
                                  ),
                                );
                                Future.delayed(const Duration(seconds: 2));
                                bloc.add(SaveInSharedPerfsEvent());
                              }
                            : null,
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
            ),
          ),
        );
      },
    );
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
