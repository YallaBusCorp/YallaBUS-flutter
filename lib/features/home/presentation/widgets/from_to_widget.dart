import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_bus/core/custom_widgets/text_widget.dart';
import 'package:yalla_bus/core/extensions/extensions.dart';
import 'package:yalla_bus/core/resources/colors_manager.dart';
import 'package:yalla_bus/core/resources/string_manager.dart';
import 'package:yalla_bus/core/resources/values_manager.dart';
import 'package:yalla_bus/features/home/presentation/widgets/from_to_body.dart';
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
                child: const FromToBody(),
              ),
            ),
          ),
        );
      },
    );
  }
}
