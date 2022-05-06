import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_bus/core/custom_widgets/text_widget.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';
import 'package:yalla_bus/core/resources/colors_manager.dart';
import 'package:yalla_bus/core/resources/string_manager.dart';
import 'package:yalla_bus/core/resources/values_manager.dart';
import 'package:yalla_bus/features/home/presentation/widgets/painting.dart';
import '../../../../core/custom_widgets/separtor_widget.dart';
import '../../../../core/injection/di.dart';
import '../bloc/map/map_bloc.dart';

class FromToWidget extends StatefulWidget {
  const FromToWidget({Key? key}) : super(key: key);

  @override
  State<FromToWidget> createState() => _FromToWidgetState();
}

class _FromToWidgetState extends State<FromToWidget> {
  MapBloc bloc = di<MapBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return Visibility(
          visible: !(bloc.perfs.getBool('Booked') ?? false),
          child: Positioned(
            top: MediaQuery.of(context).size.height - ValuesManager.v240,
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width - ValuesManager.v20,
                padding: const EdgeInsets.all(ValuesManager.v8),
                decoration: BoxDecoration(
                  boxShadow: selectShadow(context),
                  color: ColorsExtensions.setColorOfContainersOverMap(context),
                  borderRadius: BorderRadius.circular(ValuesManager.v16),
                ),
                child: Row(
                  children: [
                    const Painting(),
                    const SizedBox(width: ValuesManager.v10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: StringManager.from.tr(),
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      fontSize: ValuesManager.v16,
                                    ),
                          ),
                          BlocBuilder<MapBloc, MapState>(
                            builder: (context, state) {
                              return InkWell(
                                onTap: () {
                                  bloc.add(GetPickUpPointsEvent());
                                  
                                },
                                child: TextWidget(
                                  text: bloc.from,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                          fontSize: ValuesManager.v20,
                                          color: ColorsExtensions
                                              .checkSelectedOrNot(
                                                  bloc.from,
                                                  StringManager.pickUpPoint,
                                                  context)),
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: ValuesManager.v8),
                            child: Separtor(
                              color: [ColorsManager.blue2, ColorsManager.green],
                            ),
                          ),
                          TextWidget(
                            text: StringManager.to.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(fontSize: ValuesManager.v16),
                          ),
                          BlocBuilder<MapBloc, MapState>(
                            builder: (context, state) {
                              return InkWell(
                                onTap: () {
                                  bloc.add(GetDropOffPointsEvent());
                                },
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: TextWidget(
                                    text: bloc.to,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                          fontSize: ValuesManager.v20,
                                          color: ColorsExtensions
                                              .checkSelectedOrNot(
                                                  bloc.to,
                                                  StringManager.dropOffPoint,
                                                  context),
                                        ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
