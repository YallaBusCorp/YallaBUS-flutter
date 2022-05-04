import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_bus/features/home/presentation/bloc/map/map_bloc.dart';
import 'package:yalla_bus/features/home/presentation/widgets/painting.dart';

import '../../../../core/custom_widgets/separtor_widget.dart';
import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/injection/di.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/values_manager.dart';

class FromToBody extends StatelessWidget {
  const FromToBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MapBloc bloc = di<MapBloc>();
    return Row(
      children: [
        const Painting(),
        const SizedBox(width: ValuesManager.v10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: StringManager.from.tr(),
                style: Theme.of(context).textTheme.headline6!.copyWith(
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
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontSize: ValuesManager.v20,
                          color: ColorsExtensions.checkSelectedOrNot(
                              bloc.from, StringManager.pickUpPoint, context)),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: ValuesManager.v8),
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
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontSize: ValuesManager.v20,
                              color: ColorsExtensions.checkSelectedOrNot(
                                  bloc.to, StringManager.dropOffPoint, context),
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
    );
  }
}
