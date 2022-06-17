import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/map/map_bloc.dart';
import '../painting.dart';

import '../../../../../core/custom_widgets/button_widget.dart';
import '../../../../../core/custom_widgets/text_widget.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/resources/values_manager.dart';

class RideInfo extends StatelessWidget {
  const RideInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MapBloc bloc = BlocProvider.of<MapBloc>(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ValuesManager.v16),
       
        color: Theme.of(context).backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Painting(),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: 'From ${bloc.perfs.getString('PickUp')}',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  TextWidget(
                    text: 'To ${bloc.perfs.getString('DropOff')}',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 18),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: [
                TextWidget(
                  text: '22',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontSize: 45),
                ),
                TextWidget(
                  text: 'Km',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
