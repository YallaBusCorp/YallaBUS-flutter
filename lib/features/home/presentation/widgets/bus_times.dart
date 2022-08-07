import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/ride_booking/ride_booking_bloc.dart';
import '../../../../core/resources/values_manager.dart';

import '../../../../core/custom_widgets/text_widget.dart';
import '../../../../core/resources/colors_manager.dart';
import '../bloc/map/map_bloc.dart';

class BusTimes extends StatefulWidget {
  final List<String> times;
  final String amOrPm;
  const BusTimes({Key? key, required this.times, required this.amOrPm})
      : super(key: key);

  @override
  State<BusTimes> createState() => _BusTimesState();
}

class _BusTimesState extends State<BusTimes> {
  late RideBookingBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<RideBookingBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ValuesManager.v50,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: widget.times.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: ValuesManager.v10,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return ChoiceChip(
                elevation: ValuesManager.v1,
                padding: const EdgeInsets.all(ValuesManager.v8),
                selectedColor: ColorsManager.orange,
                backgroundColor: Theme.of(context).backgroundColor,
                label: TextWidget(
                  text: widget.times[index],
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: ValuesManager.v18),
                ),
                selected: widget.amOrPm == 'AM'
                    ? bloc.selectedAmShips[index]
                    : bloc.selectedPmShips[index],
                onSelected: (s) {
                  widget.amOrPm == 'AM'
                      ? selectAMTrip(index)
                      : selectPMTrip(index);
                },
              );
            },
          );
        },
      ),
    );
  }

  void selectAMTrip(int index) {
    setState(() {
      bloc.selectedAmShips[index] = !bloc.selectedAmShips[index];
      if (bloc.previousIndex != 10) {
        bloc.selectedAmShips[bloc.previousIndex] =
            !bloc.selectedAmShips[bloc.previousIndex];
      }
      bloc.previousIndex = index;
    });
    bloc.add(SelectAMTripEvent(widget.times[index]));
  }

  void selectPMTrip(int index) {
    setState(() {
      bloc.selectedPmShips[index] = !bloc.selectedPmShips[index];
      if (bloc.previousIndexOfPm != 10) {
        bloc.selectedPmShips[bloc.previousIndexOfPm] =
            !bloc.selectedPmShips[bloc.previousIndexOfPm];
      }
      bloc.previousIndexOfPm = index;
    });
    bloc.add(SelectPMTripEvent(widget.times[index]));
  }
}
