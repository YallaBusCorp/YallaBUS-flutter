import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/resources/colors_manager.dart';
import '../bloc/bus_ride_bloc.dart';

import '../../../../../core/custom_widgets/Decoration_widget.dart';

class UnavailableRide extends StatefulWidget {
  const UnavailableRide({Key? key}) : super(key: key);

  @override
  State<UnavailableRide> createState() => _UnavailableRideState();
}

class _UnavailableRideState extends State<UnavailableRide> {
  late BusRideBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<BusRideBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecorationBoxWidget(
      child: Padding(
        padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'There is not ride yet!',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.grey, fontSize: 18),
              ),
            ),
            TextButton(
              onPressed: () {
                bloc.add(CheckIfThereIsCurrentRideOrNotEvent());
              },
              child: Text(
                'Refersh',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: ColorsManager.orange, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
